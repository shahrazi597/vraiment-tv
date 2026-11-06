#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 5 : le casque à réduction de bruit.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "casque"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"micro", "inverse", "londe", "antibruit", "sannulent", "silence", "deuxieme", "corrige", "graves", "reguliers",
        "aigues", "voisin", "1936", "lenvers", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "silence": "silence", "ajoute": "ajoute", "bruit": "bruit", "antibruit": "antibruit", "comment": "comment",
        "micro": "micro", "ecoute": "ecoute", "moteur1": "moteur", "metro": "metro", "puce": "puce", "dessine": "dessine",
        "londe": "londe", "quand1": "quand", "monte1": "monte", "descend1": "descend", "joue": "joue",
        "sadditionnent": "sadditionnent", "sannulent": "sannulent", "deuxieme": "deuxieme", "reste": "reste",
        "corrige": "corrige", "fou": "fou", "graves": "graves", "reguliers": "reguliers", "voix": "voix",
        "passent": "passent", "voisin": "voisin", "lidee": "lidee", "y1936": "1936", "lenvers": "lenvers",
        "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["e1"], C["e2"], C["e3"], C["e4"] = (f("etape", nth=n) for n in (1, 2, 3, 4))
    C["bruit1"] = f("bruit", after=C["e1"])
    C["descend2"] = f("descend", nth=2)
    C["monte2"] = f("monte", nth=2)
    C["silence2"] = f("silence", after=C["sannulent"])
    C["micro2"] = f("micro", after=C["deuxieme"])
    C["ecoute2"] = f("ecoute", after=C["deuxieme"])
    C["moteur"] = f("moteur", after=C["fou"])
    C["silenceC"] = f("silence", after=C["y1936"])
    C["bruitC"] = f("bruit", after=C["silenceC"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.0, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "comment", EMPH)

    s = kit.Sfx(HERE)
    s.add("impact-bass-1", C["ajoute"], 0.3, maxdur=0.9)
    s.add("stamp", C["antibruit"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["comment"] - 0.2, 0.22)
    for k in ("e1", "e2", "e3", "e4"):
        s.add("click-soft", C[k], 0.16)
    s.add("pop", C["micro"] - 0.05, 0.22)
    s.add("whoosh", C["sannulent"] - 0.1, 0.16, maxdur=1.0)
    s.add("ticker", C["lidee"] + 0.05, 0.2, maxdur=1.0)
    s.add("stamp2", C["lenvers"], 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["comment"] - 0.2
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
