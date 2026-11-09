#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 11 : la retraite par répartition.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "retraite"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"depense", "moisci", "28", "11", "17", "aussitot", "repartition", "droits", "trimestres", "points", "demain",
        "304", "172", "2", "422", "milliards", "4", "gateau", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "cotises": "cotises", "pas": "pas", "toi": "toi", "depense": "depense", "moisci": "moisci", "comment": "comment",
        "salaire": "salaire", "n100": "100", "n28": "28", "n11": "11", "n17": "17", "patron": "patron",
        "caisses": "caisses", "argent": "argent", "versent": "versent", "aussitot": "aussitot", "retraites": "retraites",
        "repartition": "repartition", "echange": "echange", "droits": "droits", "trimestres": "trimestres",
        "points": "points", "calculer": "calculer", "pension": "pension", "actifs": "actifs", "demain": "demain",
        "probleme": "probleme", "n304": "304", "cotisants": "cotisants", "n172": "172", "moins": "moins",
        "facture": "facture", "n422": "422", "pres": "pres", "sur4": "sur", "voila": "voila", "lage": "lage",
        "cotisations": "cotisations", "montant": "montant", "gateau": "gateau", "abonne": "abonnetoi"}.items()}
    C["e1"], C["e2"], C["e3"] = (f("etape", nth=n) for n in (1, 2, 3))
    C["retraites2"] = f("retraites", after=C["n172"])
    C["n4"] = f("4", after=C["pres"])
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
    s.add("whoosh-short", C["pas"] - 0.1, 0.18)
    s.add("stamp", C["depense"] - 0.05, 0.4, maxdur=0.7)
    s.add("whoosh-short", C["comment"] - 0.15, 0.2)
    s.add("ticker", C["n28"] - 0.1, 0.2, maxdur=0.9)
    s.add("whoosh", C["versent"] - 0.05, 0.16, maxdur=0.8)
    s.add("pop", C["trimestres"] - 0.1, 0.2)
    s.add("pop", C["points"] - 0.1, 0.2)
    s.add("ticker", C["n304"] - 0.1, 0.18, maxdur=1.0)
    s.add("impact-bass-1", C["moins"] - 0.05, 0.24, maxdur=0.8)
    s.add("stamp2", C["pres"] + 0.1, 0.4, maxdur=0.7)
    s.add("click-soft", C["gateau"] - 0.1, 0.2)
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
