#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Spécial : les élections de mi-mandat (04/11/2026).

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → midterms_FR.mp4 + vérifications
"""
import json, os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "kit"))
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"congres", "mimandat", "435", "tiers", "1946", "deux", "historique", "chambres", "1988", "1932",
        "musulman", "president", "loi", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "pourtant": "pourtant", "perdre": "perdre", "congres": "congres", "comment": "comment",
        "elections": "elections", "mimandat": "mimandat", "tous": "tous", "revotent": "revotent", "toute": "toute",
        "chambre": "chambre", "n435": "435", "et_senat": "et", "tiers": "tiers", "senat": "senat",
        "depuis": "depuis", "y1946": "1946", "parti": "parti", "perd": "perd", "sauf": "sauf", "fois": "fois",
        "mais": "mais", "historique": "historique", "democrates": "democrates", "prennent": "prennent",
        "chambres": "chambres", "ils": "ils", "texas": "texas", "premiere": "premiere", "y1988": "1988",
        "kansas": "kansas", "y1932": "1932", "michigan": "michigan", "abdul": "abdul", "devient": "devient",
        "musulman": "musulman", "etatsunis": "etatsunis", "alors": "alors", "fini": "fini", "non": "non",
        "reste": "reste", "janvier": "janvier", "aucune": "aucune", "loi": "loi", "passe": "passe", "sans": "sans",
        "abonne": "abonnetoi"}.items()}
    C["et_senat"] = f("et", after=C["n435"])
    C["depuis_tx"] = f("depuis", after=C["texas"])
    C["depuis_ks"] = f("depuis", after=C["kansas"])
    C["et_mi"] = f("et", after=C["y1932"])
    C["vraiment"] = f("vraiment", after=C["abonne"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 2.2, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "comment", EMPH)

    s = kit.Sfx(HERE)
    s.add("stamp", C["congres"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["comment"] - 0.12, 0.22)
    s.add("click-soft", C["chambre"], 0.16)
    s.add("ticker", C["y1946"] + 0.05, 0.14, maxdur=3.4)
    s.add("pop", C["sauf"], 0.26)
    s.add("impact-bass-1", C["chambres"] + 0.05, 0.34, maxdur=1.4)
    s.add("ticker", C["depuis_tx"], 0.13, maxdur=0.9)
    s.add("ticker", C["depuis_ks"], 0.13, maxdur=0.9)
    s.add("pop", C["musulman"], 0.26)
    s.add("whoosh-short", C["alors"] - 0.12, 0.2)
    s.add("stamp2", C["sans"], 0.45, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["comment"] - 0.12
    extra = {"HOOK_D": T1 + 0.4, "MAIN_S": T1 - 0.05, "MAIN_D": C["abonne"] - (T1 - 0.05),
             "CTA_S": C["abonne"] - 0.15, "CTA_D": END - (C["abonne"] - 0.15),
             "CAPS_S": cap_data[0]["start"], "CAPS_D": END - cap_data[0]["start"]}
    kit.write_html(HERE, A("src/scene.tpl"), END, C, cap_html, cap_data, s, extra)
    json.dump({"cues": C, "sfx": s.placed, "tokens": toks}, open(A("build-report.json"), "w"), ensure_ascii=False, indent=1)
    print(f"index.html · {END:.2f} s · {len(cap_data)} sous-titres · {len(s.placed)} bruitages")


def mix(video):
    rep = json.load(open(A("build-report.json")))
    C = rep["cues"]
    out = os.path.join(os.path.dirname(HERE), "midterms_FR.mp4")
    kit.mix(HERE, video, out, C["end"], C["voEnd"], rep["sfx"])
    print(os.path.basename(out), kit.verify(out, A("assets/voix.mp3")))


if __name__ == "__main__":
    {"build": lambda: build(), "mix": lambda: mix(sys.argv[2])}[sys.argv[1]]()
