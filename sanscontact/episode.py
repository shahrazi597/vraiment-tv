#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 3 : le paiement sans contact.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "sanscontact"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"batterie", "aucune", "terminal", "antenne", "13", "millions", "courant", "reveille", "seul", "varier", "centimetres", "seteint", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "batterie": "batterie", "aucune": "aucune", "alors": "alors", "energie": "energie", "du": "du",
        "secret": "secret", "antenne": "antenne", "autour": "autour", "champ": "champ", "magnetique": "magnetique",
        "oscille": "oscille", "treize": "13", "seconde": "seconde", "approches": "approches", "traverse": "traverse",
        "courant": "courant", "puce": "puce", "reveille": "reveille", "calcule": "calcule", "code": "code",
        "seul": "seul", "renvoie": "renvoie", "varier": "varier", "et_si": "si", "eloignes": "eloignes",
        "centimetres": "centimetres", "plus2": "plus", "seteint": "seteint", "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["terminal"] = f("terminal", after=C["du"])
    C["terminal2"] = f("terminal", after=C["champ"] - 2)
    C["et_si"] = f("et", after=C["varier"])
    C["plus2"] = f("plus", after=C["centimetres"])
    C["cree"] = f("cree")
    C["e1"], C["e2"], C["e3"], C["e4"] = (f("etape", nth=n) for n in (1, 2, 3, 4))
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 2.2, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "secret", EMPH)

    s = kit.Sfx(HERE)
    s.add("stamp", C["aucune"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["terminal"] - 0.15, 0.22)
    for k in ("e1", "e2", "e3", "e4"):
        s.add("click-soft", C[k], 0.16)
    s.add("hiss", C["oscille"], 0.16, maxdur=1.2)
    s.add("pop", C["reveille"], 0.28)
    s.add("ticker", C["calcule"], 0.22, maxdur=0.9)
    s.add("kaching2", C["varier"] + 0.2, 0.26, maxdur=1.0)
    s.add("stamp2", C["seteint"], 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["secret"] - 0.2
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
