#!/usr/bin/env python3
"""Mixage final : voix + bruitages (placements de build-report.json) + musique automatisée,
puis pose du son sur la vidéo rendue sans réencoder l'image.

Usage : python3 mix.py <video_rendue.mp4> <sortie.mp4>
"""
import json, os, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
A = lambda p: os.path.join(HERE, p)
SR = 48000

UNDER, PAYOFF, OUTRO = 0.16, 0.2, 0.6      # gain de la musique sous la voix, au payoff, sur la carte de fin
MUSIC_OFFSET = 1.255                        # le payoff « Résultat » tombe sur un temps fort de la musique
FADE_OUT = 1.6


def dur(p):
    return float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", p],
                                capture_output=True, text=True).stdout)


def envelope(points, end):
    """Expression ffmpeg linéaire par morceaux (t en secondes) + fondu de sortie."""
    expr = f"{points[-1][1]}"
    for (t0, v0), (t1, v1) in reversed(list(zip(points, points[1:]))):
        seg = f"({v0}+({v1}-{v0})*(t-{t0})/({t1}-{t0}))"
        expr = f"if(lt(t,{t1}),{seg},{expr})"
    expr = f"if(lt(t,{points[0][0]}),{points[0][1]},{expr})"
    fade = f"if(gt(t,{end - FADE_OUT}),max(0,({end}-t)/{FADE_OUT}),1)"
    return f"({expr})*{fade}"


def main(video, out):
    rep = json.load(open(A("build-report.json")))
    C, sfx = rep["cues"], rep["sfx"]
    end = C["end"]
    r, ve = C["resultat"], C["voEnd"]
    pts = [(0, UNDER), (r - 0.55, UNDER), (r - 0.35, 0.03), (r - 0.03, 0.03), (r, PAYOFF),
           (ve - 0.1, PAYOFF), (ve + 0.35, OUTRO)]

    inputs = ["-i", A("assets/voix.mp3"), "-i", A("assets/music.mp3")]
    fc = [f"[1:a]aresample={SR},aformat=channel_layouts=stereo,apad=whole_dur={end}[vo]",
          f"[2:a]aresample={SR},aformat=channel_layouts=stereo,atrim={MUSIC_OFFSET}:{MUSIC_OFFSET + end},"
          f"asetpts=PTS-STARTPTS,volume='{envelope(pts, end)}':eval=frame,apad=whole_dur={end}[mu]"]
    labels = ["[vo]", "[mu]"]
    for i, (name, start, d, vol) in enumerate(sfx):
        inputs += ["-i", A(f"assets/sfx/{name}.mp3")]
        k = i + 3
        fo = min(0.2, d / 3)
        fc.append(f"[{k}:a]aresample={SR},aformat=channel_layouts=stereo,atrim=0:{d},asetpts=PTS-STARTPTS,"
                  f"afade=t=out:st={max(0, d - fo):.3f}:d={fo:.3f},volume={vol},"
                  f"adelay={int(round(start * 1000))}:all=1[s{i}]")
        labels.append(f"[s{i}]")
    # bus effets + musique compressé par la voix (la voix passe toujours devant), puis limiteur doux
    fc.append(f"{''.join(labels[1:])}amix=inputs={len(labels) - 1}:normalize=0:duration=longest,atrim=0:{end}[bed]")
    fc.append("[vo]asplit=2[vo1][vokey]")
    fc.append("[bed][vokey]sidechaincompress=threshold=0.05:ratio=4:attack=15:release=250:makeup=1[bedd]")
    fc.append(f"[vo1][bedd]amix=inputs=2:normalize=0:duration=longest,atrim=0:{end},"
              f"alimiter=limit=0.89:attack=5:release=60:level=false,aresample={SR}[mix]")
    tmp = out.replace(".mp4", ".tmp.mp4")
    cmd = ["ffmpeg", "-v", "error", "-y", "-i", video, *inputs, "-filter_complex", ";".join(fc),
           "-map", "0:v", "-map", "[mix]", "-c:v", "copy", "-c:a", "aac", "-b:a", "192k", "-t", str(end), tmp]
    subprocess.run(cmd, check=True)
    os.replace(tmp, out)

    # stems pour contrôler l'écart voix / musique
    def lufs(filt, extra_inputs):
        o = subprocess.run(["ffmpeg", "-hide_banner", *extra_inputs, "-filter_complex", filt, "-f", "null", "-"],
                           capture_output=True, text=True).stderr
        return [l.strip() for l in o.splitlines() if l.strip().startswith(("I:", "Peak:"))][-2:]
    print("voix seule     :", lufs(f"[0:a]atrim=0:{ve},ebur128=peak=true", ["-i", A("assets/voix.mp3")]))
    print("musique (sous voix, 2-20 s):",
          lufs(f"[0:a]atrim={MUSIC_OFFSET + 2}:{MUSIC_OFFSET + 20},volume={UNDER},ebur128=peak=true",
               ["-i", A("assets/music.mp3")]))
    print("mix final      :", lufs("[0:a]ebur128=peak=true", ["-i", out]))


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
