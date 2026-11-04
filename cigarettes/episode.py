#!/usr/bin/env python3
"""Combien ça coûte vraiment ? — Épisode 2 : le paquet de cigarettes.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "cigarettes"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"1350", "euro", "laccise", "55", "889", "tva", "225", "139", "97", "centimes", "8", "letat", "vraiment", "fixe"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "p1350": "1350", "fabricant": "fabricant", "touche": "touche", "pas": "pas", "euro": "euro", "regarde": "regarde",
        "accise": "laccise", "taxe": "taxe", "p55": "55", "prix": "prix", "montant": "montant", "fixe": "fixe",
        "total": "total", "v889": "889", "tva": "tva", "v225": "225", "buraliste": "buraliste", "v139": "139",
        "v97": "97", "centimes": "centimes", "avec": "avec", "fabriquer": "fabriquer", "emballer": "emballer",
        "livrer": "livrer", "resultat": "resultat", "huit": "8", "partent": "partent", "etat": "letat",
        "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["fab2"] = f("fabricant", after=C["buraliste"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 2.4, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "regarde", EMPH)

    s = kit.Sfx(HERE)
    s.add("kaching", C["p1350"], 0.3, maxdur=1.2)
    s.add("stamp", C["pas"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["regarde"] - 0.2, 0.22)
    s.add("pour", C["accise"], 0.22, maxdur=1.0)
    s.add("ticker", C["v889"] - 0.1, 0.26, maxdur=1.0)
    s.add("pour", C["tva"], 0.2, maxdur=0.9)
    s.add("click-soft", C["buraliste"], 0.2)
    s.add("pop", C["v97"], 0.28)
    s.add("impact-bass-1", C["resultat"], 0.22, maxdur=0.6)
    s.add("stamp2", C["etat"], 0.42, maxdur=0.7)
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
