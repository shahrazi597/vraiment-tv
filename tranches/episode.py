#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 7 : les tranches d'impôt.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → export final (sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SLUG = "tranches"
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"escalier", "0", "11", "30", "41", "45", "que", "sa", "000", "zero", "978", "421", "126", "104", "7", "70", "centimes", "jamais", "moins", "vraiment"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "moins": "moins", "jamais1": "jamais", "alors": "alors", "imagine": "imagine", "escalier": "escalier",
        "puis": "puis", "p41": "41", "p45": "45", "secret": "secret", "chaque": "chaque", "touche": "touche",
        "exemple": "exemple", "seul": "seul", "premiers": "premiers", "zero": "zero", "suivants": "suivants",
        "n1978": "978", "n421": "421", "n126": "126", "total": "total", "n2104": "104", "fou": "fou",
        "augmentation": "augmentation", "laisse": "laisse", "c70": "70", "abonne": "abonnetoi"}.items()}
    C["jamais2"] = f("jamais", after=C["jamais1"] + 0.1)
    C["m1"], C["m2"], C["m3"] = (f("marche", after=C["imagine"], nth=n) for n in (1, 2, 3))
    C["n11a"] = f("11", after=C["m1"])
    C["z0"] = f("0", after=C["m1"])
    C["n29a"] = f("29", after=C["m2"])
    C["p11"] = f("11", after=C["n29a"])
    C["dessus1"] = f("audessus", after=C["m3"])
    C["p30"] = f("30", after=C["m3"])
    C["euros1"] = f("euros", after=C["touche"])
    C["sa"] = f("sa", after=C["touche"])
    C["marche_sa"] = f("marche", after=C["sa"])
    C["n30k"] = f("30", after=C["exemple"])
    C["tranche2"] = f("tranche", after=C["fou"])
    C["mais2"] = f("mais", after=C["fou"])
    C["seulement2"] = f("seulement", after=C["fou"])
    C["p7"] = f("7", after=C["fou"])
    C["revenus2"] = f("revenus", after=C["p7"])
    C["et3"] = f("et", after=C["revenus2"])
    C["euro3"] = f("euro", after=C["augmentation"])
    C["jamais3"] = f("jamais", after=C["c70"])
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
    s.add("stamp", C["jamais1"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["alors"] - 0.15, 0.22)
    for k in ("m1", "m2", "m3"):
        s.add("click-soft", C[k], 0.18)
    s.add("pop", C["p45"] - 0.05, 0.2)
    s.add("ticker", C["n1978"] - 0.1, 0.2, maxdur=1.0)
    s.add("kaching2", C["n2104"], 0.24, maxdur=1.0)
    s.add("impact-bass-1", C["p7"], 0.26, maxdur=0.8)
    s.add("kaching", C["laisse"], 0.22, maxdur=1.0)
    s.add("stamp2", C["jamais3"], 0.42, maxdur=0.7)
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
