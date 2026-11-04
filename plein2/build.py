#!/usr/bin/env python3
"""Génère index.html à partir du script, des timings mot à mot de la voix et des bruitages.

Usage : python3 build.py            (utilise assets/words.json s'il existe, sinon une estimation)
"""
import difflib, json, os, re, subprocess, unicodedata
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)

SCRIPT = ("Ton plein d'essence ? 124 euros. Mais l'essence elle-même ? Même pas la MOITIÉ ! "
          "Regarde. 60 litres de SP95 : 123,78 €. "
          "Le carburant — pétrole, raffinage, transport, station — 61,74 €. Et c'est tout ! "
          "Ensuite, l'accise, la taxe carburant : 41,40 € ! "
          "Et le meilleur ? La TVA se calcule AUSSI sur la taxe. 20,64 € de plus. "
          "Résultat : un euro sur deux part direct à l'État ! "
          "Abonne-toi pour savoir combien ça coûte VRAIMENT.")

EMPH = {"124", "moitie", "6000", "12378", "6174", "4140", "aussi", "2064", "letat", "vraiment", "60"}
FPS = 30


def norm(s):
    s = unicodedata.normalize("NFD", s.lower())
    s = "".join(c for c in s if unicodedata.category(c) != "Mn")
    return re.sub(r"[^a-z0-9]", "", s)


def tokens():
    out = []
    for raw in SCRIPT.split():
        if norm(raw) == "" and out:          # ":", "—", "?", "!", "€" se collent au mot d'avant
            out[-1]["text"] += (" " if raw in "€:?!" else " ") + raw
            continue
        out.append({"text": raw})
    for t in out:
        t["key"] = norm(t["text"])
    return out


def estimate(toks):
    t, words = 0.15, []
    for tk in toks:
        d = 0.055 * len(tk["key"]) + 0.09
        words.append({"text": tk["text"], "start": round(t, 3), "end": round(t + d, 3)})
        t += d + (0.22 if re.search(r"[.!?:—]$", tk["text"]) else 0.02)
    return words


def align(toks, words):
    """Associe chaque mot du script à un mot transcrit ; interpole ceux qui n'ont pas d'équivalent."""
    a = [t["key"] for t in toks]
    b = [norm(w["text"]) for w in words]
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    for blk in sm.get_matching_blocks():
        for k in range(blk.size):
            toks[blk.a + k]["start"] = words[blk.b + k]["start"]
            toks[blk.a + k]["end"] = words[blk.b + k]["end"]
    # interpolation des trous (souvent les nombres, transcrits en lettres)
    n = len(toks)
    i = 0
    while i < n:
        if "start" in toks[i]:
            i += 1
            continue
        j = i
        while j < n and "start" not in toks[j]:
            j += 1
        t0 = toks[i - 1]["end"] if i > 0 else 0.1
        # fin du trou : premier mot transcrit après le dernier mot aligné qui précède
        t1 = toks[j]["start"] if j < n else words[-1]["end"]
        # si des mots transcrits non alignés existent dans l'intervalle, on prend leur étendue
        inside = [w for w in words if w["start"] >= t0 - 0.01 and w["end"] <= t1 + 0.01]
        if inside:
            t0, t1 = min(w["start"] for w in inside), max(w["end"] for w in inside)
        span = [len(toks[k]["key"]) + 1 for k in range(i, j)]
        tot, acc = sum(span), 0
        for k in range(i, j):
            toks[k]["start"] = round(t0 + (t1 - t0) * acc / tot, 3)
            acc += span[k - i]
            toks[k]["end"] = round(t0 + (t1 - t0) * acc / tot, 3)
        i = j
    return toks


def peak(path):
    """Instant (s) du pic d'énergie d'un fichier son, pour caler le pic une image après l'action."""
    raw = subprocess.run(["ffmpeg", "-v", "error", "-i", path, "-ac", "1", "-ar", "8000", "-f", "f32le", "-"],
                         capture_output=True).stdout
    x = np.abs(np.frombuffer(raw, dtype=np.float32))
    if not len(x):
        return 0.0
    win = 80
    env = np.convolve(x, np.ones(win) / win, mode="same")
    # attaque : premier instant à moins de 6 dB du maximum (un riser se cale sur son sommet)
    return float(np.argmax(env >= 0.5 * env.max()) / 8000)


def dur(path):
    out = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", path],
                         capture_output=True, text=True).stdout.strip()
    return float(out or 0)


def main():
    toks = tokens()
    wpath = A("assets/words.json")
    words = json.load(open(wpath)) if os.path.exists(wpath) else estimate(toks)
    # Whisper coupe « d'essence » en « d » + « 'essence » et isole la ponctuation : on recolle
    merged = []
    for w in words:
        if merged and (w["text"][:1] in "'’-" ):
            merged[-1] = {**merged[-1], "text": merged[-1]["text"] + w["text"], "end": w["end"]}
        elif norm(w["text"]) == "":
            if merged:
                merged[-1]["end"] = max(merged[-1]["end"], w["end"])
        else:
            merged.append(dict(w))
    words = merged
    toks = align(toks, words)
    vo = A("assets/voix.mp3")
    vo_end = max(words[-1]["end"], toks[-1]["end"])

    def find(key, after=0.0, nth=1):
        for t in toks:
            if t["key"] == key and t["start"] >= after - 1e-6:
                nth -= 1
                if nth == 0:
                    return t["start"]
        raise SystemExit(f"cue introuvable : {key}")

    C = {}
    C["p124"] = find("124")
    C["mais"] = find("mais")
    C["moitie"] = find("moitie")
    C["regarde"] = find("regarde")
    C["l60"] = find("60")
    C["p12378"] = find("12378")
    C["carburant"] = find("carburant")
    C["petrole"] = find("petrole")
    C["raffinage"] = find("raffinage")
    C["transport"] = find("transport")
    C["station"] = find("station")
    C["v6174"] = find("6174")
    C["tout"] = find("tout")
    C["accise"] = find("laccise")
    C["v4140"] = find("4140")
    C["meilleur"] = find("meilleur")
    C["tva"] = find("tva")
    C["aussi"] = find("aussi")
    C["v2064"] = find("2064")
    C["resultat"] = find("resultat")
    C["euro"] = find("euro", C["resultat"])
    C["deux"] = find("deux", C["resultat"])
    C["etat"] = find("letat")
    C["abonne"] = find("abonnetoi")
    C["vraiment"] = find("vraiment")
    C["voEnd"] = vo_end
    END = round(max(vo_end + 2.4, dur(vo) + 0.3), 2)
    C["end"] = END

    # ---------- sous-titres (à partir de « Regarde ») ----------
    first = next(i for i, t in enumerate(toks) if t["key"] == "regarde")
    groups, cur = [], []
    for t in toks[first:]:
        cur.append(t)
        if re.search(r"[.!?:—,]$", t["text"]) or len(cur) == 3:
            groups.append(cur)
            cur = []
    if cur:
        groups.append(cur)
    cap_html, cap_data = [], []
    for gi, g in enumerate(groups):
        gs = max(g[0]["start"] - 0.06, (cap_data[-1]["end"] if cap_data else 0))
        nxt = groups[gi + 1][0]["start"] - 0.06 if gi + 1 < len(groups) else g[-1]["end"] + 0.6
        ge = max(nxt, g[-1]["end"] + 0.05)
        spans = []
        wd = []
        for wi, t in enumerate(g):
            wid = f"w{gi}_{wi}"
            txt = re.sub(r"\s*[—,]$", "", t["text"]).strip()
            cls = "wd em" if t["key"] in EMPH else "wd"
            spans.append(f'<span id="{wid}" class="{cls}">{txt}</span>')
            wd.append({"id": wid, "t": t["start"]})
        cap_html.append(f'        <div id="g{gi}" class="cap"><span class="in">{" ".join(spans)}</span></div>')
        cap_data.append({"id": f"g{gi}", "start": round(gs, 3), "end": round(ge, 3), "w": wd})

    # ---------- bruitages ----------
    sfx_files = {k: A(f"assets/sfx/{k}.mp3") for k in
                 ["whoosh", "whoosh-short", "whoosh-cinematic", "pop", "riser", "impact-bass-1", "impact-bass-2",
                  "key-press", "click-soft", "kaching", "kaching2", "ticker", "pour", "stamp", "stamp2"]}
    sfx_files = {k: v for k, v in sfx_files.items() if os.path.exists(v)}
    pk = {k: peak(v) for k, v in sfx_files.items()}
    dd = {k: dur(v) for k, v in sfx_files.items()}
    F = 1 / FPS
    pops = [k for k in ["pop", "click-soft"] if k in sfx_files]
    placed = []

    def sfx(name, at, vol=0.6, alt=None, maxdur=None):
        name = name if name in sfx_files else alt
        if not name or name not in sfx_files:
            return
        start = max(0.0, at + F - pk[name])
        d = min(dd[name], pk[name] + 0.9) if maxdur is None else min(dd[name], maxdur)
        placed.append((name, round(start, 3), round(d, 3), vol))

    # Peu de bruitages, chacun sur une action précise, tous nettement sous la voix
    sfx("kaching", C["p124"], 0.32, "impact-bass-1", maxdur=1.2)
    sfx("stamp", C["moitie"], 0.4, "impact-bass-2", maxdur=0.7)
    sfx("whoosh-short", C["l60"] - 0.25, 0.22)
    sfx("ticker", C["l60"], 0.3, "key-press", maxdur=1.0)
    sfx("kaching2", C["l60"] + max(1.0, C["p12378"] - C["l60"] + 0.35), 0.28, "pop", maxdur=1.3)
    sfx("pour", C["carburant"], 0.22, None, maxdur=1.0)
    sfx("pour", C["accise"], 0.2, None, maxdur=1.0)
    sfx("stamp2", C["aussi"], 0.36, "impact-bass-2", maxdur=0.7)
    sfx("impact-bass-1", C["resultat"], 0.22, maxdur=0.6)
    sfx("kaching", C["etat"], 0.3, "impact-bass-2", maxdur=1.2)
    sfx("pop", C["abonne"] + 0.35, 0.28)

    audio_html = [f'      <audio id="vo" src="assets/voix.mp3" data-start="0" data-duration="{dur(vo):.3f}" data-volume="1"></audio>']
    if os.path.exists(A("assets/music.mp3")):
        md = min(dur(A("assets/music.mp3")) - 1.255, END)
        r, ve = C["resultat"], vo_end
        UNDER, PAYOFF, OUTRO = 0.2, 0.24, 0.55
        pts = [(0, UNDER), (r - 0.55, UNDER), (r - 0.35, 0.03), (r - 0.03, 0.03), (r, PAYOFF),
               (ve - 0.1, PAYOFF), (ve + 0.35, OUTRO)]
        lane = {"version": 1, "lanes": [{"target": "volume", "points": [{"t": round(t, 3), "v": v} for t, v in pts]}]}
        auto = json.dumps(lane).replace('"', "&quot;")
        audio_html.append(f'      <audio id="music" src="assets/music.mp3" data-start="0" data-media-start="1.255" data-duration="{md:.3f}" '
                          f'data-volume="1" data-fade-out="1.6" data-automation="{auto}"></audio>')
    for i, (name, st, d, vol) in enumerate(placed):
        audio_html.append(f'      <audio id="sfx{i}" src="assets/sfx/{name}.mp3" data-start="{st}" data-duration="{d}" '
                          f'data-volume="{vol}" data-fade-out="{min(0.2, d / 3):.2f}"></audio>')

    html = open(A("src/template.tpl"), encoding="utf-8").read()
    sc = {"HOOK_D": C["l60"] - 0.05,
          "MAIN_S": C["l60"] - 0.3, "MAIN_D": C["resultat"] + 0.1 - (C["l60"] - 0.3),
          "BIL_S": C["resultat"] - 0.05, "BIL_D": C["abonne"] + 0.05 - (C["resultat"] - 0.05),
          "CTA_S": C["abonne"] - 0.1, "CTA_D": END - (C["abonne"] - 0.1),
          "CAPS_S": cap_data[0]["start"], "CAPS_D": END - cap_data[0]["start"]}
    for k, v in sc.items():
        html = html.replace(f"%%{k}%%", f"{v:.3f}")
    html = (html.replace("%%END%%", f"{END}")
                .replace("%%AUDIO%%", "\n".join(audio_html))
                .replace("%%CAPTIONS%%", "\n".join(cap_html))
                .replace("%%CUES%%", json.dumps({k: round(v, 3) for k, v in C.items()}))
                .replace("%%CAPDATA%%", json.dumps(cap_data, ensure_ascii=False)))
    open(A("index.html"), "w", encoding="utf-8").write(html)
    json.dump({"cues": C, "tokens": toks, "sfx": placed}, open(A("build-report.json"), "w"), ensure_ascii=False, indent=1)
    print(f"index.html écrit · durée {END}s · {len(groups)} groupes de sous-titres · {len(placed)} bruitages"
          f" · timings {'réels' if os.path.exists(wpath) else 'estimés'}")
    for k in ["mais", "moitie", "regarde", "carburant", "accise", "tva", "aussi", "resultat", "abonne", "voEnd"]:
        print(f"  {k:10s} {C[k]:6.2f}")


if __name__ == "__main__":
    main()
