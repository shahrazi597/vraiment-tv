# Production quotidienne — Vraiment.TV

Ce fichier est le mode d'emploi suivi chaque soir par la tâche planifiée. Il produit les **3 vidéos du lendemain** et les programme.

## Créneaux (heure de Bruxelles)
| Créneau | Série |
|---|---|
| 09:00 | Comment ça marche vraiment ? |
| 12:00 | Combien ça coûte vraiment ? |
| 19:00 | Comment ça marche vraiment ? |

Priorité à « Comment ça marche vraiment ? » (2 vidéos sur 3). Un sujet n'est jamais publié deux fois : vérifier `kit/sujets.md` et `queue/`.

## 0. Préparer la machine
```bash
[ -d /home/claude/video/.git ] || git clone https://github.com/shahrazi597/vraiment-tv /home/claude/video
cd /home/claude/video && git pull
mkdir -p .secrets && chmod 700 .secrets
printf '%s' "$PASSPHRASE" > .secrets/passphrase   # donnée dans la tâche
openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 -pass file:.secrets/passphrase -in secrets.enc | tar -C .secrets -xf - && chmod 600 .secrets/*
pip install --break-system-packages -q faster-whisper numpy
which ffmpeg || (apt-get install -y ffmpeg || pip install --break-system-packages imageio-ffmpeg)
```
Lire `kit/DA.md` (identité, à respecter à la lettre), `kit/kit.py`, et un épisode modèle complet : `frigo/` (episode.py, script.txt, src/scene.tpl). Charger les skills `hyperframes` et `hyperframes-cli` avant d'animer.

## 1. Choisir 3 sujets
- Prendre les prochains sujets ⏳ de `kit/sujets.md` (ou en ajouter de nouveaux, tendance, qui intriguent tout le monde).
- Vérifier chaque fait avec WebSearch/WebFetch sur au moins 2 sources fiables (organisme officiel, université, régulateur). Pour « Combien ça coûte », utiliser les **chiffres les plus récents** et écrire la date des prix.
- Si une accroche ne tient pas, la reformuler ou changer de sujet.

## 2. Pour chaque vidéo (dossier `<slug>/`, sur le modèle de `frigo/`)
1. **Script** (`script.txt`), 30 à 35 s : accroche qui contredit une idée reçue → un mécanisme en 3-4 étapes → chute qui surprend → « Abonne-toi… vraiment ? ». Tags de voix [excited] [curious] [mischievously].
2. **Voix** : ElevenLabs `creative_generate_speech`, voix Kevin `zVrWtLr70jn6SeaARX0i`, modèle eleven_v4. Garder la meilleure prise. Puis `kit.prep_voice` et `kit.transcribe` → `assets/words.json`.
3. **Image IA** seulement si elle apporte vraiment (≈ 1 vidéo sur 3) : bytedance-seedream-5-pro, 9:16.
4. **Animation** HyperFrames (`src/scene.tpl` + `episode.py build`) : schéma animé du mécanisme, sous-titres karaoké, pastille de série, tampon rouge, carte de fin avec sources. Bruitages depuis `kit/assets/sfx` (12 max).
5. `npx hyperframes check`, puis regarder des images clés (`snapshot`) : aucun texte coupé, rien sous 1330 px, image 0 = accroche lisible.
6. **Rendu** puis `python3 episode.py mix <rendu.mp4>` → `<slug>_FR.mp4` à la racine. **Pas de musique.** `kit.verify` doit confirmer une seule voix et ≈ −14,5 LUFS.
7. Si une étape échoue après 2 essais : passer au sujet suivant plutôt que publier une vidéo ratée.

## 3. Textes de publication (dans `queue/AAAA-MM-JJ-HHMM-<slug>.json`)
Champs : `video` (nom du mp4), `when` (`AAAA-MM-JJTHH:MM:00`, heure de Bruxelles), `series`, `ep`, `tiktok`, `instagram`, `yt_title`, `yt_desc`. Modèles : les fichiers `queue/2026-11-04-*`.
- **TikTok** : 1-2 phrases choc + question pour les commentaires + « 🤖 Voix et visuels générés par IA » + 5 à 7 hashtags (2-3 larges comme #lesaviezvous #pourtoi #apprendresurtiktok, 3-4 précis au sujet).
- **Instagram** : 3-4 lignes qui donnent envie + appel au commentaire et à l'abonnement + mention IA + 8 à 10 hashtags (mélange larges/précis, dont #reelsfrance #culturegenerale).
- **YouTube** : titre ≤ 70 caractères avec emoji + « #shorts » ; description : résumé, « <Série> Épisode N », mention IA, sources, 3-5 hashtags.
- Vérifier quelles hashtags sont tendance cette semaine en français (WebSearch) et en intégrer 1-2 pertinentes.

## 4. Programmer
```bash
python3 kit/publish.py zernio queue/<fichier>.json        # TikTok + YouTube à l'heure "when"
python3 kit/publish.py ig-prepare queue/<fichier>.json    # conteneur Instagram prêt (publié par la tâche du créneau)
```
Programmer chaque vidéo **dès qu'elle est prête** (ne pas attendre les 3).

## 5. Ranger
- `kit/sujets.md` : passer le sujet en 📅 avec la date.
- `kit/publications.md` : ajouter les textes.
- `git add -A && git commit && git push` (jamais `.secrets/`, jamais de mp4).
- Résumé final : les 3 sujets, heures, et tout problème rencontré.
