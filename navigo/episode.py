#!/usr/bin/env python3
"""Combien ça coûte vraiment ? — Épisode 3 : le passe Navigo.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "navigo"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"9080", "280", "mois", "cher", "moitie", "4540", "3310", "1947", "entreprises", "13669", "versement", "mobilite",
        "metro", "1", "6", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "p9080": "9080", "vrai": "vrai", "p280": "280", "chaque": "chaque", "trains": "trains", "bus": "bus",
        "conducteurs": "conducteurs", "elec": "lelectricite", "cher": "cher", "alors": "alors", "regarde": "regarde",
        "dabord": "dabord", "toi": "toi", "employeur": "employeur", "moitie": "moitie", "v4540": "4540",
        "collectivites": "collectivites", "region": "region", "paris": "paris", "departements": "departements",
        "v3310": "3310", "pub": "pub", "amendes": "amendes", "taxes": "taxes", "v1947": "1947", "gros": "gros",
        "entreprises": "entreprises", "v13669": "13669", "presque": "presque", "taxe": "taxe", "versement": "versement",
        "meme": "meme", "metro": "metro", "resultat": "resultat", "moins": "moins", "six": "6",
        "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["toi9080"] = f("9080", after=C["toi"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.2, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "trains", EMPH)

    s = kit.Sfx(HERE)
    s.add("kaching", C["p9080"], 0.28, maxdur=1.2)
    s.add("ticker", C["p280"] - 0.35, 0.24, maxdur=1.0)
    s.add("stamp", C["chaque"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["regarde"] - 0.2, 0.22)
    s.add("pour", C["toi"], 0.2, maxdur=0.9)
    s.add("click-soft", C["moitie"], 0.2)
    s.add("pour", C["collectivites"], 0.18, maxdur=0.8)
    s.add("pop", C["pub"], 0.24)
    s.add("impact-bass-1", C["entreprises"], 0.24, maxdur=0.6)
    s.add("ticker", C["v13669"] - 0.1, 0.24, maxdur=1.0)
    s.add("stamp2", C["moins"], 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    extra = {"HOOK_D": C["regarde"] + 0.05, "MAIN_S": C["regarde"] - 0.3, "MAIN_D": C["resultat"] + 0.1 - (C["regarde"] - 0.3),
             "BIL_S": C["resultat"] - 0.05, "BIL_D": C["abonne"] + 0.05 - (C["resultat"] - 0.05),
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
