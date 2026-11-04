#!/usr/bin/env python3
"""Publication Vraiment.TV — TikTok + YouTube via Zernio, Instagram via l'API officielle (Graph API).

Secrets (jamais dans le dépôt en clair) :
  ZERNIO_KEY  ou fichier ~/video/.secrets/zernio_key
  IG_TOKEN    ou fichier ~/video/.secrets/instagram_token

  python3 publish.py upload <video.mp4>                 → URL publique (CDN Zernio)
  python3 publish.py zernio <queue.json> [--now|--dry]  → programme TikTok + YouTube à l'heure "when" (Europe/Brussels)
  python3 publish.py ig-prepare <queue.json>            → crée le conteneur Reel (valable 24 h), écrit ig_container dans le json
  python3 publish.py ig-publish <queue.json>            → publie le conteneur (ou le crée puis publie)
  python3 publish.py status <queue.json>                → état des publications
Le fichier queue/*.json contient : video, when, tiktok, instagram, yt_title, yt_desc (+ ids écrits ici).
"""
import json, os, sys, time, urllib.request, urllib.error, urllib.parse

ZBASE = "https://zernio.com/api/v1"
GBASE = "https://graph.facebook.com/v21.0"
IG_USER = "17841432756244727"          # @vraiment.tv
TIKTOK_ACC = "6aeafd125748051d2f82ed3c"  # Zernio — @vraiment.tv
YOUTUBE_ACC = "6aeafe5d70d6c124bad88af7"  # Zernio — @vraimenttv
TZ = "Europe/Brussels"
SECRETS = os.path.expanduser(os.environ.get("VRAIMENT_SECRETS", "/home/claude/video/.secrets"))


def secret(env, fname):
    v = os.environ.get(env)
    if v:
        return v.strip()
    return open(os.path.join(SECRETS, fname)).read().strip()


def http(method, url, body=None, headers=None, raw=None, timeout=300):
    h = dict(headers or {})
    data = raw
    if body is not None:
        data = json.dumps(body).encode()
        h["Content-Type"] = "application/json"
    req = urllib.request.Request(url, data=data, method=method, headers=h)
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            txt = r.read().decode() or "{}"
            return r.status, json.loads(txt) if txt.strip().startswith(("{", "[")) else txt
    except urllib.error.HTTPError as e:
        txt = e.read().decode()
        try:
            return e.code, json.loads(txt)
        except Exception:
            return e.code, txt


def z(method, path, body=None):
    return http(method, ZBASE + path, body, {"Authorization": "Bearer " + secret("ZERNIO_KEY", "zernio_key")})


def upload(path):
    size = os.path.getsize(path)
    st, r = z("POST", "/media/presign", {"filename": os.path.basename(path), "contentType": "video/mp4", "size": size})
    if st >= 300:
        raise SystemExit(f"presign {st}: {r}")
    with open(path, "rb") as f:
        st2, r2 = http("PUT", r["uploadUrl"], raw=f.read(), headers={"Content-Type": "video/mp4"}, timeout=900)
    if st2 >= 300:
        raise SystemExit(f"upload {st2}: {r2}")
    return r["publicUrl"]


def load(qpath):
    return json.load(open(qpath, encoding="utf-8"))


def save(qpath, q):
    json.dump(q, open(qpath, "w", encoding="utf-8"), ensure_ascii=False, indent=1)


def video_url(qpath, q):
    if not q.get("video_url"):
        vp = q["video"] if os.path.isabs(q["video"]) else os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(qpath))), q["video"])
        q["video_url"] = upload(vp)
        save(qpath, q)
    return q["video_url"]


def zernio(qpath, mode="schedule"):
    q = load(qpath)
    url = video_url(qpath, q)
    body = {
        "content": q["tiktok"],
        "mediaItems": [{"type": "video", "url": url}],
        "timezone": TZ,
        "platforms": [
            {"platform": "tiktok", "accountId": TIKTOK_ACC, "customContent": q["tiktok"],
             "platformSpecificData": {"privacyLevel": "PUBLIC_TO_EVERYONE", "allowComment": True, "allowDuet": True,
                                      "allowStitch": True, "commercialContentType": "none", "contentPreviewConfirmed": True,
                                      "expressConsentGiven": True, "videoMadeWithAi": True, "videoCoverTimestampMs": 0}},
            {"platform": "youtube", "accountId": YOUTUBE_ACC, "customContent": q["yt_desc"],
             "platformSpecificData": {"title": q["yt_title"][:100], "visibility": "public", "madeForKids": False,
                                      "containsSyntheticMedia": True, "categoryId": "27", "notifySubscribers": True}},
        ],
    }
    if mode == "now":
        body["publishNow"] = True
    else:
        body["scheduledFor"] = q["when"]
    if mode == "dry":
        body["dryRun"] = True
    st, r = z("POST", "/posts", body)
    print(st, json.dumps(r, ensure_ascii=False)[:1500])
    if st < 300 and mode != "dry":
        q["zernio_post"] = (r.get("post") or {}).get("_id")
        save(qpath, q)
    return st < 300


def g(method, path, params):
    params = dict(params, access_token=secret("IG_TOKEN", "instagram_token"))
    if method == "GET":
        return http("GET", GBASE + path + "?" + urllib.parse.urlencode(params))
    return http("POST", GBASE + path, raw=urllib.parse.urlencode(params).encode(),
                headers={"Content-Type": "application/x-www-form-urlencoded"})


def ig_prepare(qpath):
    q = load(qpath)
    url = video_url(qpath, q)
    st, r = g("POST", f"/{IG_USER}/media", {"media_type": "REELS", "video_url": url, "caption": q["instagram"], "share_to_feed": "true"})
    if st >= 300:
        raise SystemExit(f"IG container {st}: {r}")
    cid = r["id"]
    for _ in range(60):  # jusqu'à 10 min de traitement
        st, s = g("GET", f"/{cid}", {"fields": "status_code,status"})
        code = s.get("status_code") if isinstance(s, dict) else None
        if code == "FINISHED":
            break
        if code in ("ERROR", "EXPIRED"):
            raise SystemExit(f"IG container {code}: {s}")
        time.sleep(10)
    q["ig_container"], q["ig_container_at"] = cid, int(time.time())
    save(qpath, q)
    print("conteneur prêt", cid, code)
    return cid


def ig_already(q):
    """Anti-doublon : un Reel publié dans les 3 dernières heures avec le même début de légende ?"""
    st, r = g("GET", f"/{IG_USER}/media", {"fields": "id,caption,timestamp,permalink", "limit": "10"})
    if st >= 300 or not isinstance(r, dict):
        return None
    head = q["instagram"][:60]
    import datetime as dt
    now = dt.datetime.now(dt.timezone.utc)
    for m in r.get("data", []):
        t = dt.datetime.strptime(m["timestamp"], "%Y-%m-%dT%H:%M:%S%z")
        if (m.get("caption") or "")[:60] == head and (now - t).total_seconds() < 3 * 3600:
            return m
    return None


def ig_publish(qpath):
    q = load(qpath)
    if q.get("ig_media"):
        print("déjà publié", q["ig_media"]); return True
    m = ig_already(q)
    if m:
        q["ig_media"], q["ig_permalink"] = m["id"], m.get("permalink")
        save(qpath, q)
        print("déjà publié sur Instagram :", m.get("permalink")); return True
    cid = q.get("ig_container")
    if not cid or time.time() - q.get("ig_container_at", 0) > 23 * 3600:
        cid = ig_prepare(qpath); q = load(qpath)
    st, r = g("POST", f"/{IG_USER}/media_publish", {"creation_id": cid})
    if st >= 300:  # conteneur expiré ou refusé : on en refait un
        cid = ig_prepare(qpath); q = load(qpath)
        st, r = g("POST", f"/{IG_USER}/media_publish", {"creation_id": cid})
    print(st, r)
    if st < 300:
        q["ig_media"] = r["id"]
        st2, p = g("GET", f"/{r['id']}", {"fields": "permalink"})
        q["ig_permalink"] = p.get("permalink") if isinstance(p, dict) else None
        save(qpath, q)
        print("Instagram :", q["ig_permalink"])
    return st < 300


def status(qpath):
    q = load(qpath)
    if q.get("zernio_post"):
        st, r = z("GET", f"/posts/{q['zernio_post']}")
        p = r.get("post", r) if isinstance(r, dict) else r
        print("Zernio:", p.get("status"), [(x.get("platform"), x.get("status"), x.get("platformPostUrl") or x.get("errorMessage")) for x in p.get("platforms", [])])
    print("Instagram:", q.get("ig_permalink") or q.get("ig_container") or "—")


if __name__ == "__main__":
    cmd, arg = sys.argv[1], sys.argv[2]
    if cmd == "upload":
        print(upload(arg))
    elif cmd == "zernio":
        mode = "now" if "--now" in sys.argv else "dry" if "--dry" in sys.argv else "schedule"
        sys.exit(0 if zernio(arg, mode) else 1)
    elif cmd == "ig-prepare":
        ig_prepare(arg)
    elif cmd == "ig-publish":
        sys.exit(0 if ig_publish(arg) else 1)
    elif cmd == "status":
        status(arg)
    elif cmd == "slot":  # ex. slot 1900 → publie le Reel du créneau du jour ; slot auto → créneau le plus proche
        import glob, datetime as dt, zoneinfo
        now = dt.datetime.now(zoneinfo.ZoneInfo(TZ))
        day = now.strftime("%Y-%m-%d")
        if arg == "auto":  # lancé par GitHub Actions un peu avant l'heure : attend l'heure exacte puis publie
            best = None
            for hm in ("0900", "1200", "1900"):
                t = now.replace(hour=int(hm[:2]), minute=int(hm[2:]), second=0, microsecond=0)
                delta = (t - now).total_seconds()
                if -75 * 60 <= delta <= 30 * 60:
                    best = (hm, delta)
            if not best:
                print(f"{now:%H:%M} : aucun créneau dans la fenêtre, rien à faire."); sys.exit(0)
            arg, delta = best
            if delta > 0:
                print(f"créneau {arg} dans {int(delta)} s, j'attends"); sys.stdout.flush(); time.sleep(delta)
        here = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        files = sorted(glob.glob(os.path.join(here, "queue", f"{day}-{arg}-*.json")))
        if not files:
            print(f"AUCUNE vidéo prévue pour {day} {arg} : la production d'hier a échoué pour ce créneau."); sys.exit(2)
        ok = ig_publish(files[0])
        status(files[0])
        sys.exit(0 if ok else 1)
