#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 2 : une IA comme ChatGPT.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "ia"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"tokens", "nombres", "montagnes", "probabilite", "tire", "recommence", "centaines", "petit", "lis", "vraiment", "apres"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "connait": "connait", "avance": "lavance", "il": "il", "devine": "devine", "mot": "mot",
        "question": "question", "decoupee": "decoupee", "morceaux": "morceaux", "tokens": "tokens",
        "chacun": "chacun", "nombres": "nombres", "pendant": "pendant", "lu": "lu", "montagnes": "montagnes",
        "textes": "textes", "apprendre": "apprendre", "vient": "vient", "apres": "apres", "autre": "autre",
        "chaque": "chaque", "possible": "possible", "calcule": "calcule", "probabilite": "probabilite",
        "tire": "tire", "lajoute": "lajoute", "phrase": "phrase", "recommence": "recommence",
        "centaines": "centaines", "reponse2": "reponse", "cest": "cest", "saffiche": "saffiche",
        "lecrit": "lecrit", "lis": "lis", "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["reponse2"] = f("reponse", after=C["centaines"])
    C["mot2"] = f("mot", after=C["mot"] + 0.05)
    C["e1"], C["e2"], C["e3"], C["e4"] = (f("etape", nth=n) for n in (1, 2, 3, 4))
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 2.2, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "etape", EMPH)

    s = kit.Sfx(HERE)
    s.add("stamp", C["mot"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["e1"] - 0.2, 0.22)
    for k in ("e1", "e2", "e3", "e4"):
        s.add("click-soft", C[k], 0.16)
    s.add("pop", C["morceaux"], 0.24)
    s.add("whoosh", C["montagnes"] - 0.1, 0.2, maxdur=1.2)
    s.add("ticker", C["probabilite"] - 0.1, 0.24, maxdur=1.1)
    s.add("pop", C["tire"] + 0.1, 0.26)
    s.add("stamp2", C["lis"], 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["e1"] - 0.25
    extra = {"HOOK_D": T1 + 0.35, "MAIN_S": T1 - 0.05, "MAIN_D": C["abonne"] - (T1 - 0.05),
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
