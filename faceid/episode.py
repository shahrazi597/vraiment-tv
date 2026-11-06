#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 6 : Face ID.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "faceid"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"30", "000", "invisibles", "infrarouge", "relief", "mathematique", "chiffres", "deverrouille", "noir", "million", "jumeau", "chances", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "bombarde": "bombarde", "n30": "30", "invisibles": "invisibles", "comment": "comment", "haut": "haut",
        "projecteur": "projecteur", "envoie": "envoie", "infrarouge": "infrarouge", "voient": "voient", "camera": "camera",
        "filme": "filme", "decalent": "decalent", "relief": "relief", "transforme": "transforme", "modele": "modele",
        "chiffres": "chiffres", "enregistre": "enregistre", "chiffre": "chiffre", "zone": "zone", "securisee": "securisee",
        "colle": "colle", "deverrouille": "deverrouille", "fou": "fou", "noir": "noir", "eclaire": "eclaire",
        "inconnu": "inconnu", "million": "million", "mais2": "mais", "jumeau": "jumeau", "chances": "chances",
        "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["e1"], C["e2"], C["e3"], C["e4"] = (f("etape", nth=n) for n in (1, 2, 3, 4))
    C["sur"] = f("sur", after=C["inconnu"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.0, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "comment", EMPH)

    s = kit.Sfx(HERE)
    s.add("hiss", C["bombarde"], 0.16, maxdur=1.0)
    s.add("stamp", C["invisibles"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["comment"] - 0.2, 0.22)
    for k in ("e1", "e2", "e3", "e4"):
        s.add("click-soft", C[k], 0.16)
    s.add("ticker", C["transforme"] + 0.1, 0.2, maxdur=1.0)
    s.add("kaching2", C["deverrouille"], 0.26, maxdur=1.0)
    s.add("ticker", C["sur"], 0.2, maxdur=1.0)
    s.add("stamp2", C["chances"], 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["comment"] - 0.2
    extra = {"HOOK_D": T1 + 0.35, "MAIN_S": T1 - 0.05, "MAIN_D": C["abonne"] - (T1 - 0.05),
             "FACE_D": C["inconnu"] + 0.5,
             "CTA_S": C["abonne"] - 0.15, "CTA_D": END - (C["abonne"] - 0.15),
             "CAPS_S": cap_data[0]["start"], "CAPS_D": END - cap_data[0]["start"]}
    kit.write_html(HERE, A("src/scene.tpl"), END, C, cap_html, cap_data, s, extra)
    json.dump({"cues": C, "sfx": s.placed, "tokens": toks}, open(A("build-report.json"), "w"), ensure_ascii=False, indent=1)
    print(f"index.html · {END:.2f} s · {len(cap_data)} sous-titres · {len(s.placed)} bruitages")


def mix(video):
    rep = json.load(open(A("build-report.json")))
    C = rep["cues"]
    out = os.path.join(os.path.dirname(HERE), f"{SLUG}_FR.mp4")
    kit.mix(HERE, video, out, C["end"], C["voEnd"], rep["sfx"])
    print(os.path.basename(out), kit.verify(out, A("assets/voix.mp3")))


if __name__ == "__main__":
    {"build": lambda: build(), "mix": lambda: mix(sys.argv[2])}[sys.argv[1]]()
