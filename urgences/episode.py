#!/usr/bin/env python3
"""Combien ça coûte vraiment ? — Épisode 7 : un passage aux urgences.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "urgences"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"23", "10", "fixe", "meme", "prix", "responsable", "rembourse", "jour", "vrai", "56", "milliards", "208",
        "270", "95", "lassurance", "maladie", "csg", "3", "heures", "juste", "part", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "urgences": "urgences", "n23": "23", "mais": "mais", "coute": "coute", "n10": "10", "fois": "fois", "combien": "combien",
        "ta": "ta", "depuis": "depuis", "forfait": "forfait", "fixe": "fixe", "meme": "meme", "consultation": "consultation",
        "radio": "radio", "suture": "suture", "mutuelle": "mutuelle", "responsable": "responsable", "rembourse": "rembourse",
        "hospitalise": "hospitalise", "jour": "jour", "maintenant": "maintenant", "vrai": "vrai", "n56": "56",
        "n208": "208", "passages": "passages", "n270": "270", "moyenne": "moyenne", "n95": "95", "lassurance": "lassurance",
        "donc": "donc", "csg": "csg", "bonus": "bonus", "moitie": "moitie", "patients": "patients", "n3": "3",
        "heures": "heures", "bref": "bref", "juste": "juste", "abonne": "abonnetoi"}.items()}
    C["n23b"] = f("23", after=C["fixe"])
    C["n23c"] = f("23", after=C["hospitalise"])
    C["n23d"] = f("23", after=C["bref"])
    C["urgences2"] = f("urgences", after=C["maintenant"])
    C["prix2"] = f("prix", after=C["bref"])
    C["part2"] = f("part", after=C["juste"])
    C["vraiment"] = f("vraiment", after=C["abonne"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.0, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "combien", EMPH)

    s = kit.Sfx(HERE)
    s.add("pop", C["n23"] - 0.1, 0.22)
    s.add("impact-bass-1", C["n10"] - 0.05, 0.26, maxdur=0.8)
    s.add("whoosh-short", C["combien"] - 0.15, 0.2)
    s.add("kaching", C["n23b"] - 0.05, 0.18, maxdur=0.9)
    s.add("click-soft", C["radio"] - 0.1, 0.2)
    s.add("pop", C["hospitalise"] - 0.1, 0.2)
    s.add("whoosh", C["maintenant"] - 0.1, 0.16, maxdur=0.8)
    s.add("ticker", C["n56"] - 0.1, 0.18, maxdur=1.0)
    s.add("kaching2", C["n270"] - 0.05, 0.2, maxdur=1.0)
    s.add("ticker", C["n3"] - 0.1, 0.16, maxdur=0.8)
    s.add("stamp", C["prix2"] + 0.1, 0.4, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["combien"]
    extra = {"HOOK_D": T1 + 0.7, "MAIN_S": T1 - 0.05, "MAIN_D": C["abonne"] - (T1 - 0.05),
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
