# Production quotidienne — Vraiment.TV

Ce fichier est le mode d'emploi suivi chaque soir par la tâche planifiée. Il produit les **3 vidéos du lendemain** et les programme.

## Créneaux (heure de Bruxelles)
| Créneau | Série |
|---|---|
| 09:00 | Comment ça marche vraiment ? |
| 12:00 | Combien ça coûte vraiment ? |
| 19:00 | Comment ça marche vraiment ? |

Priorité à « Comment ça marche vraiment ? » (2 vidéos sur 3). Un sujet n'est jamais publié deux fois : vérifier `kit/sujets.md` et `queue/`. Un créneau déjà occupé par un fichier `queue/AAAA-MM-JJ-HHMM-*.json` (vidéo décalée ou d'avance) n'est pas reproduit : ne produire que les créneaux libres.

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
Lire `kit/DA.md` (identité, à respecter à la lettre), `kit/kit.py`, et deux épisodes modèles complets : `frigo/` et `midterms/` (episode.py, script.txt, src/scene.tpl). Charger les skills `hyperframes` et `hyperframes-cli` avant d'animer.

## 1. Choisir les sujets
**Lire d'abord la « Ligne éditoriale » en tête de `kit/sujets.md`** (consigne de Razi, à partir du 08/11/2026). En résumé : les gens se fichent de savoir comment marche un frigo. Ils veulent **apprendre de vraies choses**, plus cultivantes, qu'ils retrouvent dans leur vie : leur argent (impôts, banque, crédit, prix, salaire), leur cerveau, leur corps, leur société, leur monde. Chaque sujet doit passer trois tests :
- **je le retrouve dans ma vie** ;
- **j'apprends un truc que je vais répéter à table** (idée reçue démontée, chiffre qui choque, mécanisme caché) ;
- **ça change quelque chose pour moi** : finir, quand c'est possible, sur ce que ça change concrètement pour celui qui regarde.
« Comment ça marche vraiment ? » explique surtout des **systèmes** (impôts, création monétaire, prix, cerveau, sommeil…), plus des objets techniques. Prendre les sujets des sections « Priorité » de `kit/sujets.md` ; la « Réserve » seulement si rien d'autre ne tient. On peut ajouter un sujet encore meilleur (tendance de la semaine, saison), en respectant les trois tests.

**Seul sujet interdit : l'alcool** (consigne de Razi). Pas de sujet politique ou religieux sans demande explicite de Razi. Pour le reste, viser la vidéo la plus forte et les visuels les plus beaux possibles.
- Vérifier chaque fait avec WebSearch/WebFetch sur au moins 2 sources fiables (organisme officiel, université, régulateur, étude publiée). Pour l'argent et les prix, utiliser les **chiffres les plus récents**, préciser le pays (France par défaut) et écrire la date des chiffres.
- Pour la santé et l'argent : informer, jamais conseiller (pas de « fais ceci avec ton argent / prends ce médicament »).
- Si une accroche ne tient pas, la reformuler ou changer de sujet.

## 2. Pour chaque vidéo (dossier `<slug>/`, sur le modèle de `frigo/`)
1. **Script** (`script.txt`), **35 à 50 s** (130 à 190 mots ; 45 s ou un peu plus est bien si le sujet le mérite, jamais de remplissage) : accroche en moins de 2 s qui contredit une idée reçue → le mécanisme en 3 à 5 étapes, chacune avec une image concrète → un « bonus » qui surprend encore (un chiffre, une conséquence inattendue) → chute → « Abonne-toi… vraiment ». Relancer l'attention toutes les 5 à 7 s (question, chiffre, rupture). Tags de voix [excited] [curious] [mischievously].
2. **Voix** : ElevenLabs `creative_generate_speech`, voix Kevin `zVrWtLr70jn6SeaARX0i`, modèle eleven_v4, **`generations_count: 1`** (budget). Transcrire et comparer au script : si un mot est mal prononcé ou changé (ex. « réalisent » au lieu de « réélisent »), reformuler la phrase et refaire une seule prise. Écrire les nombres en chiffres. Puis `kit.prep_voice` et `kit.transcribe` → `assets/words.json`.
3. **Image IA** seulement si elle apporte vraiment (≈ 1 vidéo sur 3), **1 seule variation** : bytedance-seedream-5-pro. Le modèle sort souvent du 16:9 : composer en conséquence (image en bas de l'accroche, fondu vers le fond, comme `midterms/`).
4. **Animation** HyperFrames (`src/scene.tpl` + `episode.py build`) : schéma animé du mécanisme, sous-titres karaoké, pastille de série, tampon rouge, carte de fin avec sources. Bruitages depuis `kit/assets/sfx` (12 max).
5. `npx hyperframes check`, puis regarder des images clés (`snapshot`) : aucun texte coupé, rien sous 1330 px, image 0 = accroche lisible.
6. **Rendu** puis `python3 episode.py mix <rendu.mp4>` → `<slug>_FR.mp4` à la racine. **Pas de musique.** `kit.verify` doit confirmer une seule voix et ≈ −14,5 LUFS.
7. Si une étape échoue après 2 essais : passer au sujet suivant plutôt que publier une vidéo ratée.

## 3. Textes de publication
**Jamais** de mention « généré par IA » dans les descriptions, titres ou hashtags (consigne de Razi). Les labels IA officiels des plateformes restent activés automatiquement par `publish.py`.
 (dans `queue/AAAA-MM-JJ-HHMM-<slug>.json`)
Champs : `video` (nom du mp4), `when` (`AAAA-MM-JJTHH:MM:00`, heure de Bruxelles), `series`, `ep`, `tiktok`, `instagram`, `yt_title`, `yt_desc`. Modèles : les fichiers `queue/2026-11-04-*`.
- **TikTok** : 1-2 phrases choc + question pour les commentaires + 5 à 7 hashtags (2-3 larges comme #lesaviezvous #pourtoi #apprendresurtiktok, 3-4 précis au sujet).
- **Instagram** : 3-4 lignes qui donnent envie + appel au commentaire et à l'abonnement + 8 à 10 hashtags (mélange larges/précis, dont #reelsfrance #culturegenerale).
- **YouTube** : titre ≤ 70 caractères avec emoji + « #shorts » ; description : résumé, « <Série> Épisode N », sources, 3-5 hashtags.
- Vérifier quelles hashtags sont tendance cette semaine en français (WebSearch) et en intégrer 1-2 pertinentes.

## 4. Programmer
```bash
python3 kit/publish.py zernio queue/<fichier>.json        # TikTok + YouTube à l'heure "when"
python3 kit/publish.py ig-prepare queue/<fichier>.json    # conteneur Instagram prêt (publié à l'heure par GitHub Actions / la session de contrôle)
```
Programmer chaque vidéo **dès qu'elle est prête** (ne pas attendre les 3), puis **pousser tout de suite son fichier queue** — sans lui, la publication Instagram ne peut pas partir :
```bash
git add queue/<fichier>.json && git commit -m "Programmé : <sujet>" && git pull --rebase -q && git push -q
```

## 5. Ranger
- `kit/sujets.md` : passer le sujet en 📅 avec la date.
- `kit/publications.md` : ajouter les textes.
- `git add -A && git commit && git push` (jamais `.secrets/`, jamais de mp4).
- Résumé final : les 3 sujets, heures, et tout problème rencontré.
