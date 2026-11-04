"""Outils communs à toutes les vidéos « … VRAIMENT ? ».

Chaque épisode appelle ces fonctions depuis son propre episode.py :
  prep_voice → transcribe → align → captions / cues → sfx → write_html → (rendu) → mix → verify
"""
import difflib, json, os, re, shutil, subprocess, unicodedata
import numpy as np

KIT = os.path.dirname(os.path.abspath(__file__))
FPS = 30
SR = 48000

# ---------------------------------------------------------------- DA son
VOICE_ID = "zVrWtLr70jn6SeaARX0i"        # Kevin, eleven_v4 — la voix du compte
VOICE_TEMPO = 1.10                         # débit +10 %, hauteur conservée
MUSIC = os.path.join(KIT, "assets/music_signature.mp3")   # 120 bpm, mesures de 2 s, montée à 16 s
MUSIC_UNDER, MUSIC_OUTRO = 0.16, 0.6      # ~16 dB sous la voix ; plus présente sur la carte de fin
TARGET_LUFS, TARGET_TP = -14.5, -1.5


def run(cmd, **kw):
    return subprocess.run(cmd, check=True, capture_output=True, text=True, **kw)


def dur(p):
    return float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0", p],
                                capture_output=True, text=True).stdout)


def pcm(path, sr=16000):
    raw = subprocess.run(["ffmpeg", "-v", "error", "-i", path, "-ac", "1", "-ar", str(sr), "-f", "f32le", "-"],
                         capture_output=True).stdout
    return np.frombuffer(raw, dtype=np.float32).copy()


# ---------------------------------------------------------------- projet
def install_assets(project):
    """Copie le kit (styles, scripts, polices, sons) dans assets/ de l'épisode."""
    a = os.path.join(project, "assets")
    for sub in ("sfx", "fonts"):
        os.makedirs(os.path.join(a, sub), exist_ok=True)
    for f in ["da.css", "da.js"]:
        shutil.copy(os.path.join(KIT, f), os.path.join(a, f))
    for sub in ["fonts", "sfx"]:
        src = os.path.join(KIT, "assets", sub)
        for f in os.listdir(src):
            shutil.copy(os.path.join(src, f), os.path.join(a, sub, f))
    shutil.copy(os.path.join(KIT, "assets/gsap.min.js"), os.path.join(a, "gsap.min.js"))


# ---------------------------------------------------------------- voix
def prep_voice(src, dst, tempo=VOICE_TEMPO, short_gap=0.12, long_gap=0.32, long_from=0.45):
    """Resserre les silences (les longs restent des respirations), accélère, normalise."""
    out = subprocess.run(["ffmpeg", "-hide_banner", "-i", src, "-af", "silencedetect=noise=-38dB:d=0.12", "-f", "null", "-"],
                         capture_output=True, text=True).stderr
    st = [float(x) for x in re.findall(r"silence_start: ([0-9.]+)", out)]
    en = [float(x) for x in re.findall(r"silence_end: ([0-9.]+)", out)]
    D = dur(src)
    segs, gaps, t = [], [], 0.0
    for s, e in zip(st, en):
        if s - t > 0.05:
            segs.append((max(0, t - 0.04), min(D, s + 0.04)))
            gaps.append(long_gap if e - s >= long_from else short_gap)
        t = e
    if D - t > 0.05:
        segs.append((max(0, t - 0.04), D))
    parts, labels = [], []
    for i, (a, b) in enumerate(segs):
        parts.append(f"[0:a]atrim={a:.3f}:{b:.3f},asetpts=PTS-STARTPTS,afade=t=in:d=0.015,"
                     f"afade=t=out:st={max(0, b - a - 0.02):.3f}:d=0.02[s{i}]")
        labels.append(f"[s{i}]")
        if i < len(segs) - 1:
            parts.append(f"aevalsrc=0:d={gaps[i]}:s=44100:c=mono[z{i}]")
            labels.append(f"[z{i}]")
    fc = ";".join(parts) + ";" + "".join(labels) + \
        f"concat=n={len(labels)}:v=0:a=1,aresample=44100,atempo={tempo},loudnorm=I=-15:TP=-1.5:LRA=7[out]"
    run(["ffmpeg", "-y", "-i", src, "-filter_complex", fc, "-map", "[out]", "-ac", "1", "-ar", "44100",
         "-c:a", "libmp3lame", "-b:a", "192k", dst])
    return dur(dst)


_whisper = None


def transcribe(path, prompt=""):
    global _whisper
    from faster_whisper import WhisperModel
    if _whisper is None:
        _whisper = WhisperModel("small", device="cpu", compute_type="int8")
    segs, _ = _whisper.transcribe(pcm(path), language="fr", word_timestamps=True, initial_prompt=prompt,
                                  vad_filter=False, beam_size=5)
    return [{"text": w.word.strip(), "start": round(w.start, 3), "end": round(w.end, 3)} for s in segs for w in s.words]


# ---------------------------------------------------------------- texte et timings
def norm(s):
    s = unicodedata.normalize("NFD", s.lower())
    s = "".join(c for c in s if unicodedata.category(c) != "Mn")
    return re.sub(r"[^a-z0-9]", "", s)


def tokens(script):
    """Mots du script tels qu'affichés ; la ponctuation isolée se colle au mot d'avant."""
    script = re.sub(r"\[[^\]]+\]\s*", "", script)          # retire les tags de jeu [excited]
    out = []
    for raw in script.split():
        if norm(raw) == "" and out:
            out[-1]["text"] += ("\u00a0" if raw in "€:?!%" else " ") + raw
            continue
        out.append({"text": raw})
    for t in out:
        t["key"] = norm(t["text"])
    return out


def merge_whisper(words):
    merged = []
    for w in words:
        if merged and w["text"][:1] in "'’-":
            merged[-1] = {**merged[-1], "text": merged[-1]["text"] + w["text"], "end": w["end"]}
        elif norm(w["text"]) == "":
            if merged:
                merged[-1]["end"] = max(merged[-1]["end"], w["end"])
        else:
            merged.append(dict(w))
    return merged


def align(toks, words):
    """Donne à chaque mot du script le temps du mot prononcé ; interpole les trous (nombres en lettres…)."""
    words = merge_whisper(words)
    a = [t["key"] for t in toks]
    b = [norm(w["text"]) for w in words]
    for blk in difflib.SequenceMatcher(None, a, b, autojunk=False).get_matching_blocks():
        for k in range(blk.size):
            toks[blk.a + k]["start"] = words[blk.b + k]["start"]
            toks[blk.a + k]["end"] = words[blk.b + k]["end"]
    n, i = len(toks), 0
    while i < n:
        if "start" in toks[i]:
            i += 1
            continue
        j = i
        while j < n and "start" not in toks[j]:
            j += 1
        t0 = toks[i - 1]["end"] if i > 0 else 0.1
        t1 = toks[j]["start"] if j < n else words[-1]["end"]
        inside = [w for w in words if w["start"] >= t0 - 0.01 and w["end"] <= t1 + 0.01]
        if inside:
            t0, t1 = min(w["start"] for w in inside), max(w["end"] for w in inside)
        span = [len(toks[k]["key"]) + 1 for k in range(i, j)]
        tot, acc = sum(span), 0
        for k in range(i, j):
            toks[k]["start"] = round(t0 + (t1 - t0) * acc / tot, 3)
            acc += span[k - i]
            toks[k]["end"] = round(t0 + (t1 - t0) * acc / tot, 3)
        i = j
    return toks


def finder(toks):
    def find(key, after=0.0, nth=1):
        for t in toks:
            if t["key"] == key and t["start"] >= after - 1e-6:
                nth -= 1
                if nth == 0:
                    return t["start"]
        raise SystemExit(f"cue introuvable : {key} après {after}")
    return find


def captions(toks, first_key, emph, max_words=3):
    """Groupes de 1 à 3 mots, coupés à la ponctuation. Renvoie (html, données)."""
    first = next(i for i, t in enumerate(toks) if t["key"] == first_key)
    groups, cur = [], []
    for t in toks[first:]:
        cur.append(t)
        if re.search(r"[.!?:—,…]$", t["text"]) or len(cur) == max_words:
            groups.append(cur)
            cur = []
    if cur:
        groups.append(cur)
    html, data = [], []
    for gi, g in enumerate(groups):
        gs = max(g[0]["start"] - 0.06, (data[-1]["end"] if data else 0))
        nxt = groups[gi + 1][0]["start"] - 0.06 if gi + 1 < len(groups) else g[-1]["end"] + 0.6
        ge = max(nxt, g[-1]["end"] + 0.05)
        spans, wd = [], []
        for wi, t in enumerate(g):
            wid = f"w{gi}_{wi}"
            txt = re.sub(r"\s*[—,]$", "", t["text"]).strip()
            cls = "wd em" if t["key"] in emph else "wd"
            spans.append(f'<span id="{wid}" class="{cls}">{txt}</span>')
            wd.append({"id": wid, "t": t["start"]})
        html.append(f'        <div id="g{gi}" class="cap"><span class="in">{" ".join(spans)}</span></div>')
        data.append({"id": f"g{gi}", "start": round(gs, 3), "end": round(ge, 3), "w": wd})
    return "\n".join(html), data


# ---------------------------------------------------------------- bruitages
def attack(path):
    """Instant où le son atteint la moitié de son maximum : c'est lui qu'on cale sur l'image."""
    x = np.abs(pcm(path, 8000))
    if not len(x):
        return 0.0
    env = np.convolve(x, np.ones(80) / 80, mode="same")
    return float(np.argmax(env >= 0.5 * env.max()) / 8000)


class Sfx:
    """Règles DA : 12 bruitages max, chacun causé par une action, tous sous la voix."""
    MAX = 12

    def __init__(self, project):
        self.dir = os.path.join(project, "assets/sfx")
        self.placed = []
        self._pk, self._d = {}, {}

    def add(self, name, at, vol=0.3, maxdur=None):
        p = os.path.join(self.dir, f"{name}.mp3")
        if name not in self._pk:
            self._pk[name], self._d[name] = attack(p), dur(p)
        start = max(0.0, at + 1 / FPS - self._pk[name])
        d = min(self._d[name], self._pk[name] + 0.9) if maxdur is None else min(self._d[name], maxdur)
        self.placed.append((name, round(start, 3), round(d, 3), vol))

    def html(self):
        assert len(self.placed) <= self.MAX, f"trop de bruitages ({len(self.placed)} > {self.MAX})"
        return "\n".join(
            f'      <audio id="sfx{i}" src="assets/sfx/{n}.mp3" data-start="{s}" data-duration="{d}" '
            f'data-volume="{v}" data-fade-out="{min(0.2, d / 3):.2f}"></audio>'
            for i, (n, s, d, v) in enumerate(self.placed))


# ---------------------------------------------------------------- musique signature
def music_bed(project, length, lift_at=None, offset=None):
    """Construit le tapis de la durée voulue à partir de la musique du compte, en restant sur les mesures.
    lift_at : moment (s) où la montée de la musique doit tomber, calé sur un premier temps."""
    BAR, A_END, TRACK_END = 2.0, 16.0, 30.0 - 0.6
    if offset is None:
        offset = ((-(lift_at or 0)) % BAR) if lift_at else 0.0   # le premier temps tombe sur lift_at
    segs, t, pos = [], 0.0, offset
    lift = lift_at if lift_at is not None else 1e9
    while t < length:
        if t < lift - 1e-6:                    # partie A en boucle (8 mesures)
            seg_end = min(A_END, pos + (lift - t), pos + (length - t))
            segs.append((pos, seg_end))
            t += seg_end - pos
            pos = seg_end if seg_end < A_END - 1e-6 else 0.0
            if t >= lift - 1e-6:
                pos = A_END
        else:                                  # partie B (après la montée), bouclée sur ses mesures
            if pos < A_END:
                pos = A_END
            seg_end = min(TRACK_END - ((TRACK_END - A_END) % BAR), pos + (length - t))
            segs.append((pos, seg_end))
            t += seg_end - pos
            pos = A_END + 4.0 if seg_end >= TRACK_END - 2.1 else seg_end
    parts, labels = [], []
    for i, (a, b) in enumerate(segs):
        parts.append(f"[0:a]atrim={a:.3f}:{b:.3f},asetpts=PTS-STARTPTS,afade=t=in:d=0.008,"
                     f"afade=t=out:st={max(0, b - a - 0.008):.3f}:d=0.008[m{i}]")
        labels.append(f"[m{i}]")
    out = os.path.join(project, "assets/music.mp3")
    run(["ffmpeg", "-y", "-i", MUSIC, "-filter_complex",
         ";".join(parts) + ";" + "".join(labels) + f"concat=n={len(labels)}:v=0:a=1[o]",
         "-map", "[o]", "-ar", "44100", "-ac", "2", "-c:a", "libmp3lame", "-b:a", "192k", out])
    return segs


# ---------------------------------------------------------------- page
def write_html(project, tpl_path, END, C, cap_html, cap_data, sfx, extra=None):
    html = open(tpl_path, encoding="utf-8").read()
    audio = [f'      <audio id="vo" src="assets/voix.mp3" data-start="0" data-duration="{dur(os.path.join(project, "assets/voix.mp3")):.3f}" data-volume="1"></audio>',
             sfx.html()]
    rep = {"%%END%%": f"{END}", "%%AUDIO%%": "\n".join(audio), "%%CAPTIONS%%": cap_html,
           "%%CUES%%": json.dumps({k: round(v, 3) for k, v in C.items()}),
           "%%CAPDATA%%": json.dumps(cap_data, ensure_ascii=False)}
    rep.update({f"%%{k}%%": (f"{v:.3f}" if isinstance(v, float) else str(v)) for k, v in (extra or {}).items()})
    for k, v in rep.items():
        html = html.replace(k, v)
    left = re.findall(r"%%[A-Z_]+%%", html)
    assert not left, f"marqueurs non remplacés : {left}"
    open(os.path.join(project, "index.html"), "w", encoding="utf-8").write(html)


# ---------------------------------------------------------------- mixage
def envelope(points, end, fade_out=1.6):
    expr = f"{points[-1][1]}"
    for (t0, v0), (t1, v1) in reversed(list(zip(points, points[1:]))):
        expr = f"if(lt(t,{t1}),({v0}+({v1}-{v0})*(t-{t0})/({t1}-{t0})),{expr})"
    expr = f"if(lt(t,{points[0][0]}),{points[0][1]},{expr})"
    return f"({expr})*if(gt(t,{end - fade_out}),max(0,({end}-t)/{fade_out}),1)"


def mix(project, video, out, END, voice_end, sfx_placed, with_music=False, dips=()):
    """Voix devant ; musique + bruitages sur un bus compressé par la voix ; limiteur ; −14,5 LUFS.
    L'entrée 0 est la vidéo (son ignoré), 1 la voix, 2 la musique, puis les bruitages."""
    pts = [(0, MUSIC_UNDER)]
    for d in sorted(dips):                       # trou de musique juste avant un payoff
        pts += [(d - 0.55, MUSIC_UNDER), (d - 0.35, 0.03), (d - 0.03, 0.03), (d, MUSIC_UNDER * 1.25)]
    pts += [(voice_end - 0.1, pts[-1][1]), (voice_end + 0.35, MUSIC_OUTRO)]
    A = lambda p: os.path.join(project, p)
    music = A("assets/music.mp3") if with_music else A("assets/voix.mp3")   # entrée 2 ignorée sans musique
    inputs = ["-i", video, "-i", A("assets/voix.mp3"), "-i", music]
    fc = [f"[1:a]aresample={SR},aformat=channel_layouts=stereo,apad=whole_dur={END}[vo]"]
    bed = []
    if with_music:
        fc.append(f"[2:a]aresample={SR},aformat=channel_layouts=stereo,atrim=0:{END},asetpts=PTS-STARTPTS,"
                  f"volume='{envelope(pts, END)}':eval=frame,apad=whole_dur={END}[mu]")
        bed.append("[mu]")
    for i, (name, start, d, vol) in enumerate(sfx_placed):
        inputs += ["-i", A(f"assets/sfx/{name}.mp3")]
        fo = min(0.2, d / 3)
        fc.append(f"[{i + 3}:a]aresample={SR},aformat=channel_layouts=stereo,atrim=0:{d},asetpts=PTS-STARTPTS,"
                  f"afade=t=out:st={max(0, d - fo):.3f}:d={fo:.3f},volume={vol},adelay={int(round(start * 1000))}:all=1[s{i}]")
        bed.append(f"[s{i}]")
    fc.append(f"{''.join(bed)}amix=inputs={len(bed)}:normalize=0:duration=longest,apad=whole_dur={END},atrim=0:{END}[bed]")
    fc.append("[vo]asplit=2[vo1][vokey]")
    fc.append("[bed][vokey]sidechaincompress=threshold=0.05:ratio=4:attack=15:release=250:makeup=1[bedd]")
    fc.append(f"[vo1][bedd]amix=inputs=2:normalize=0:duration=longest,atrim=0:{END},"
              f"alimiter=limit=0.89:attack=5:release=60:level=false,aresample={SR}[mix]")
    tmp = out.replace(".mp4", ".tmp.mp4")
    run(["ffmpeg", "-y", *inputs, "-filter_complex", ";".join(fc), "-map", "0:v", "-map", "[mix]",
         "-c:v", "copy", "-c:a", "aac", "-b:a", "192k", "-t", str(END), tmp])
    loudnorm2(tmp, out)
    os.remove(tmp)


def loudnorm2(src, dst):
    o = subprocess.run(["ffmpeg", "-hide_banner", "-i", src, "-af",
                        f"loudnorm=I={TARGET_LUFS}:TP={TARGET_TP}:LRA=11:print_format=json", "-f", "null", "-"],
                       capture_output=True, text=True).stderr
    m = json.loads(o[o.rindex("{"):o.rindex("}") + 1])
    f = (f"loudnorm=I={TARGET_LUFS}:TP={TARGET_TP}:LRA=11:measured_I={m['input_i']}:measured_TP={m['input_tp']}:"
         f"measured_LRA={m['input_lra']}:measured_thresh={m['input_thresh']}:offset={m['target_offset']}:linear=true")
    run(["ffmpeg", "-y", "-i", src, "-c:v", "copy", "-af", f + f",aresample={SR}", "-c:a", "aac", "-b:a", "192k", dst])


# ---------------------------------------------------------------- vérifications
def verify(out, voice):
    """Une seule voix (corrélation croisée), niveaux, pics. Renvoie un dict lisible."""
    sr = 8000
    x, v = pcm(out, sr), pcm(voice, sr)
    n = min(len(x), len(v))
    a, b = x[:n] - x[:n].mean(), v[:n] - v[:n].mean()
    N = 1 << int(np.ceil(np.log2(2 * n)))
    cc = np.fft.irfft(np.fft.rfft(a, N) * np.conj(np.fft.rfft(b, N)), N)
    cc = np.concatenate([cc[-3 * sr:], cc[:3 * sr]]) / np.sqrt(np.dot(a, a) * np.dot(b, b))
    lags = np.arange(-3 * sr, 3 * sr) / sr
    peaks = []
    for i in np.argsort(-np.abs(cc))[:600]:
        if all(abs(lags[i] - p[0]) > 0.05 for p in peaks):
            peaks.append((round(float(lags[i]), 3), round(float(cc[i]), 2)))
        if len(peaks) == 3:
            break
    o = subprocess.run(["ffmpeg", "-hide_banner", "-i", out, "-af", "ebur128=peak=true:metadata=1,ametadata=print:key=lavfi.r128.M",
                        "-f", "null", "-"], capture_output=True, text=True).stderr
    M = np.array([float(l.split("=")[1]) for l in o.splitlines() if "lavfi.r128.M=" in l and "inf" not in l])
    I = re.findall(r"I:\s+(-?[0-9.]+) LUFS", o)
    P = re.findall(r"Peak:\s+(-?[0-9.]+) dBFS", o)
    return {"voix_trouvees": peaks, "LUFS": float(I[-1]) if I else None, "peak_dBFS": float(P[-1]) if P else None,
            "momentanee_max": round(float(M.max()), 1), "momentanee_mediane": round(float(np.median(M)), 1)}
