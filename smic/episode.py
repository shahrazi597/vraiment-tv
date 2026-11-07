#!/usr/bin/env python3
"""Combien ça coûte vraiment ? — Épisode 5 : un salarié au SMIC.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "smic"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"988", "456", "532", "867", "411", "180", "csg", "crds", "retraite", "net", "121", "700", "100", "79", "197", "fond", "trappe", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "n988": "988", "mais": "mais", "touche": "touche", "seulement": "seulement", "n456": "456", "alors": "alors",
        "n532": "532", "dabord": "dabord", "salaire1": "salaire", "brut1": "brut", "n867": "867", "contrat": "contrat",
        "retire": "retire", "n411": "411", "n180": "180", "secu": "secu", "reste": "reste", "resultat": "resultat",
        "cote": "cote", "ajoute": "ajoute", "n121": "121", "niveau": "niveau", "n700": "700", "fou": "fou",
        "n100": "100", "n79": "79", "n197": "197", "reduction": "reduction", "fond": "fond", "trappe": "trappe",
        "abonne": "abonnetoi"}.items()}
    C["n456b"] = f("456", after=C["resultat"])
    C["net"] = f("net", after=C["n456b"])
    C["seulement2"] = f("seulement", after=C["n121"])
    C["brut3"] = f("brut", after=C["n100"])
    C["toi"] = f("toi", after=C["n100"])
    C["lui3"] = f("lui", after=C["n79"])
    C["plus_monte"] = f("plus", after=C["n197"], nth=2)
    C["vraiment"] = f("vraiment", after=C["abonne"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.0, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "alors", EMPH)

    s = kit.Sfx(HERE)
    s.add("kaching", C["n988"], 0.24, maxdur=1.2)
    s.add("ticker", C["seulement"], 0.2, maxdur=1.0)
    s.add("whoosh-short", C["dabord"] - 0.3, 0.22)
    s.add("ticker", C["n867"] - 0.1, 0.18, maxdur=1.0)
    s.add("click-soft", C["retire"] - 0.1, 0.18)
    s.add("kaching2", C["n456b"], 0.22, maxdur=1.0)
    s.add("click-soft", C["ajoute"] - 0.1, 0.18)
    s.add("pop", C["n700"] - 0.05, 0.2)
    s.add("whoosh-short", C["fou"] - 0.3, 0.2)
    s.add("stamp", C["n197"] + 0.4, 0.4, maxdur=0.7)
    s.add("stamp2", C["trappe"] - 0.05, 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["dabord"]
    extra = {"HOOK_D": T1 + 0.2, "MAIN_S": T1 - 0.15, "MAIN_D": C["abonne"] - (T1 - 0.15),
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
