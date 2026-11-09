#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 12 : l'effet placebo.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "placebo"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"sucre", "sais", "aucun", "mieux", "vraies", "endorphines", "dopamine", "douleur", "baisse", "contexte", "85",
        "chere", "61", "soldee", "savaient", "59", "35", "nocebo", "3", "4", "lattente", "guerit", "ressens", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "pilule": "pilule", "soulager": "soulager", "meme": "meme", "sais": "sais", "comment": "comment",
        "avales": "avales", "contient": "contient", "aucun": "aucun", "cerveau": "cerveau", "sattend": "sattend",
        "mieux": "mieux", "attente": "attente", "reactions": "reactions", "libere": "libere", "endorphines": "endorphines",
        "dopamine": "dopamine", "lactivite": "lactivite", "douleur": "douleur", "baisse": "baisse", "contexte": "contexte",
        "etude": "etude", "fausse": "fausse", "n85": "85", "chere": "chere", "n61": "61", "soldee": "soldee",
        "fou": "fou", "harvard": "harvard", "savaient": "savaient", "placebo": "placebo", "n59": "59", "n35": "35",
        "sans": "sans", "lautre": "lautre", "nocebo": "nocebo", "vaccins": "vaccins", "n4": "4",
        "dose": "dose", "venaient": "venaient", "lattente": "lattente", "attention": "attention", "guerit": "guerit",
        "maladie": "maladie", "agit": "agit", "ressens": "ressens", "abonne": "abonnetoi"}.items()}
    C["n3"] = f("3", after=C["vaccins"])
    C["sucre2"] = f("sucre", after=C["sais"])
    C["e1"], C["e2"], C["e3"] = (f("etape", nth=n) for n in (1, 2, 3))
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
    s.add("pop", C["pilule"] - 0.1, 0.2)
    s.add("stamp", C["sais"] - 0.05, 0.4, maxdur=0.7)
    s.add("whoosh-short", C["comment"] - 0.15, 0.2)
    s.add("click-soft", C["aucun"] - 0.1, 0.2)
    s.add("pop", C["endorphines"] - 0.1, 0.2)
    s.add("pop", C["dopamine"] - 0.1, 0.2)
    s.add("whoosh", C["baisse"] - 0.1, 0.14, maxdur=0.7)
    s.add("ticker", C["n85"] - 0.1, 0.18, maxdur=0.9)
    s.add("ticker", C["n59"] - 0.1, 0.18, maxdur=0.9)
    s.add("impact-bass-1", C["nocebo"] - 0.05, 0.24, maxdur=0.8)
    s.add("stamp2", C["n4"], 0.38, maxdur=0.7)
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
