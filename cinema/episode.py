#!/usr/bin/env python3
"""Combien ça coûte vraiment ? — Épisode 4 : la place de cinéma.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "cinema"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"742", "moitie", "39", "75", "cnc", "628", "10", "sacem", "322", "296", "producteur", "francais", "americain", "salle", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "p742": "742", "mais": "mais", "film": "film", "moitie": "moitie", "alors": "alors", "qui": "qui",
        "letat": "letat", "c39": "39", "c75": "75", "reste": "reste", "p628": "628", "sacem": "sacem", "c10": "10",
        "salle": "salle", "distributeur": "distributeur", "p322": "322", "p296": "296", "pub": "pub",
        "producteur": "producteur", "fou": "fou", "financer": "financer", "films": "films", "francais": "francais",
        "blockbuster": "blockbuster", "americain": "americain", "popcorn": "popcorn",
        "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["reste2"] = f("reste", after=C["sacem"])
    C["salle2"] = f("salle", after=C["distributeur"])
    C["distributeur2"] = f("distributeur", after=C["p322"])
    C["c75b"] = f("75", after=C["fou"])
    C["taxe2"] = f("taxe", after=C["fou"])
    C["et_pop"] = f("et", after=C["americain"])
    C["pas"] = f("pas", after=C["popcorn"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 3.0, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "alors", EMPH)

    s = kit.Sfx(HERE)
    s.add("kaching", C["p742"], 0.26, maxdur=1.2)
    s.add("stamp", C["moitie"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["alors"] - 0.15, 0.22)
    s.add("click-soft", C["letat"] - 0.1, 0.18)
    s.add("click-soft", C["c75"] - 0.1, 0.18)
    s.add("ticker", C["reste"], 0.22, maxdur=1.0)
    s.add("click-soft", C["sacem"] - 0.1, 0.18)
    s.add("kaching2", C["p296"], 0.24, maxdur=1.0)
    s.add("pop", C["pub"] - 0.05, 0.22)
    s.add("impact-bass-1", C["c75b"] - 0.1, 0.26, maxdur=0.8)
    s.add("stamp2", C["pas"], 0.42, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)

    T1 = C["alors"]
    extra = {"HOOK_D": T1 + 0.4, "MAIN_S": T1 - 0.05, "MAIN_D": C["abonne"] - (T1 - 0.05),
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
