#!/usr/bin/env python3
"""Comment ça marche vraiment ? — Épisode 1 : le frigo.

  python3 episode.py build                 → index.html (à vérifier puis rendre)
  python3 episode.py mix <rendu.mp4>       → deux exports finaux (avec / sans musique) + vérifications
"""
import json, os, sys
sys.path.insert(0, "/home/claude/video/kit")
import kit

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SCRIPT = open(A("script.txt"), encoding="utf-8").read()
EMPH = {"tiede", "lisobutane", "12", "sevapore", "chauffe", "liquide", "glace", "rechauffe", "vraiment", "boucle"}


def cues():
    toks = kit.align(kit.tokens(SCRIPT), json.load(open(A("assets/words.json"))))
    f = kit.finder(toks)
    C = {k: f(w) for k, w in {
        "jamais": "jamais", "il": "il", "deplace": "deplace", "chaleur": "chaleur", "pose": "pose",
        "arriere": "larriere", "cotes": "cotes", "tiede": "tiede", "part": "part", "nourriture": "nourriture",
        "secret": "secret", "gaz": "gaz", "iso": "lisobutane", "bout": "bout", "moins": "moins", "degres": "degres",
        "sevapore": "sevapore", "aspire": "aspire", "sueur": "sueur", "compresseur": "compresseur",
        "lecrase": "lecrase", "comprime": "comprime", "lexterieur": "lexterieur", "relache": "relache",
        "liquide": "liquide", "tube": "tube", "pression": "pression", "chute": "chute", "glace": "glace",
        "boucle": "boucle", "alors": "alors", "ouvrir": "ouvrir", "rechauffe": "rechauffe",
        "abonne": "abonnetoi", "vraiment": "vraiment"}.items()}
    C["e1"], C["e2"], C["e3"], C["e4"] = (f("etape", nth=n) for n in (1, 2, 3, 4))
    C["et_boucle"] = f("et", after=C["glace"])
    C["voEnd"] = max(toks[-1]["end"], kit.dur(A("assets/voix.mp3")) - 0.05)
    C["end"] = round(C["voEnd"] + 2.2, 2)
    return toks, C


def build():
    kit.install_assets(HERE)
    toks, C = cues()
    END = C["end"]
    cap_html, cap_data = kit.captions(toks, "pose", EMPH)

    s = kit.Sfx(HERE)
    s.add("stamp", C["jamais"], 0.4, maxdur=0.7)
    s.add("whoosh-short", C["pose"] - 0.15, 0.22)
    s.add("boil", C["bout"], 0.32)
    for k in ("e1", "e2", "e3", "e4"):
        s.add("click-soft", C[k], 0.16)
    s.add("compressor", C["compresseur"], 0.28, maxdur=1.8)
    s.add("hiss", C["chute"], 0.35)
    s.add("door", C["ouvrir"], 0.4)
    s.add("stamp2", C["rechauffe"], 0.45, maxdur=0.7)
    s.add("pop", C["abonne"] + 0.3, 0.28)


    T1 = C["pose"] - 0.14
    extra = {"HOOK_D": T1 + 0.3, "MAIN_S": T1 - 0.05, "MAIN_D": C["abonne"] - (T1 - 0.05),
             "CTA_S": C["abonne"] - 0.15, "CTA_D": END - (C["abonne"] - 0.15),
             "CAPS_S": cap_data[0]["start"], "CAPS_D": END - cap_data[0]["start"]}
    kit.write_html(HERE, A("src/scene.tpl"), END, C, cap_html, cap_data, s, extra)
    json.dump({"cues": C, "sfx": s.placed, "tokens": toks}, open(A("build-report.json"), "w"), ensure_ascii=False, indent=1)
    print(f"index.html · {END:.2f} s · {len(cap_data)} sous-titres · {len(s.placed)} bruitages")


def mix(video):
    rep = json.load(open(A("build-report.json")))
    C = rep["cues"]
    out_dir = os.path.dirname(HERE)
    out = os.path.join(out_dir, "frigo_FR.mp4")
    kit.mix(HERE, video, out, C["end"], C["voEnd"], rep["sfx"])
    print(os.path.basename(out), kit.verify(out, A("assets/voix.mp3")))


if __name__ == "__main__":
    {"build": lambda: build(), "mix": lambda: mix(sys.argv[2])}[sys.argv[1]]()
