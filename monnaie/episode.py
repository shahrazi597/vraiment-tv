#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 8 : la création monétaire.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "monnaie"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"cree", "10", "000", "nexistaient", "credits", "depots", "circule", "detruit", "interets", "fonds", "propres", "reserves", "rembourser", "90", "billets", "chiffres", "bce", "taux", "expres", "freiner", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "n10k": "10", "prend": "prend", "clients": "clients", "cree": "cree", "comment": "comment",
        "credit": "credit", "tape": "tape", "nexistaient": "nexistaient", "seconde": "seconde", "credits": "credits",
        "depots": "depots", "achetes": "achetes", "voiture": "voiture", "part": "part", "vendeur": "vendeur",
        "fournisseurs": "fournisseurs", "circule": "circule", "rembourses": "rembourses", "detruit": "detruit",
        "interets": "interets", "mais": "mais", "infini": "linfini", "fonds": "fonds", "reserves": "reserves",
        "verifier": "verifier", "fou": "fou", "n90": "90", "circulation": "circulation", "billets": "billets",
        "chiffres": "chiffres", "comptes": "comptes", "alors": "alors", "bce": "bce", "monte": "monte", "cher": "cher",
        "expres": "expres", "freiner": "freiner", "creation": "creation", "abonne": "abonnetoi"}.items()}
    C["e1"], C["e2"], C["e3"] = (f("etape", nth=n) for n in (1, 2, 3))
    C["n10k2"] = f("10", after=C["tape"])
    C["pas2"] = f("pas", after=C["mais"])
    C["credit3"] = f("credit", after=C["bce"])
    C["vraiment"] = f("vraiment", after=C["abonne"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.0, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "comment", EMPH)

    s = kit.Sfx(HERE)
    s.add("whoosh-short", C["clients"] - 0.1, 0.18)
    s.add("stamp", C["cree"] - 0.05, 0.4, maxdur=0.7)
    s.add("whoosh-short", C["comment"] - 0.15, 0.2)
    s.add("ticker", C["n10k2"] - 0.1, 0.2, maxdur=1.0)
    s.add("kaching", C["n10k2"] + 0.8, 0.2, maxdur=1.0)
    s.add("pop", C["achetes"] - 0.1, 0.2)
    s.add("whoosh", C["part"] - 0.05, 0.16, maxdur=0.8)
    s.add("stamp2", C["detruit"], 0.42, maxdur=0.7)
    s.add("click-soft", C["fonds"] - 0.1, 0.18)
    s.add("click-soft", C["reserves"] - 0.1, 0.18)
    s.add("impact-bass-1", C["n90"] - 0.1, 0.24, maxdur=0.8)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["comment"]
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
