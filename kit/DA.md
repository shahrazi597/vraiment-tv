# DA du compte « … VRAIMENT ? »

Une seule identité pour toutes les séries : **Combien ça coûte vraiment ?**, **Comment ça marche vraiment ?**, et les suivantes. Le mot « vraiment » est la signature du compte.

## Format
- Vertical 1080 × 1920, 30 i/s, 25 à 40 s.
- Texte et éléments importants uniquement entre 168 et 1330 px de hauteur, pour ne pas passer sous l'interface de TikTok, Reels et Shorts. Rien d'important sous la barre d'actions à droite.
- Image 0 = miniature : la phrase d'accroche est déjà à l'écran, jamais un fond vide.

## Couleurs (chacune a un sens, toujours le même)
| Rôle | Couleur |
|---|---|
| Fond | `#0b0b0e`, grille fine qui dérive lentement + halo coloré + vignette |
| Texte | `#f6f4ee` |
| **Ambre** `#ffb21f` | le mot ou le chiffre à retenir (sous-titres, titres) |
| **Rouge** `#ff5236` | l'alerte, le chaud, le tampon, le bouton « Abonne-toi » |
| **Crème** `#ece6d6` | la donnée neutre, la matière, les contours des objets |
| **Bleu froid** `#4cc4ff` | le froid, l'air, ce qui s'échappe |

## Typo
- Inter Display uniquement, en Black (900) pour les titres et ExtraBold (800) pour les étiquettes.
- Titres en majuscules, 80 à 104 px, sur 2 ou 3 lignes. Rien en dessous de 28 px.
- Chiffres tabulaires, pour que les compteurs ne tremblent pas.

## Éléments fixes
- **Pastille de série** en haut (192 px) : nom de la série en blanc, puis le numéro d'épisode en rouge.
- **Sous-titres karaoké** à 1180 px : 1 à 3 mots à la fois, le mot prononcé s'allume en blanc et les mots clés en ambre.
- **Tampon rouge penché** pour la phrase qui claque : 2 par vidéo au maximum.
- **Étiquettes arrondies** (fond `#16161b`, pastille colorée) pour les étapes et les infos.
- **Carte de fin** : nom de la série sur 3 lignes avec « VRAIMENT ? » en ambre, bouton rouge « Abonne-toi », numéro et titre de l'épisode, sources.

## Mouvement
- Arrivées : flou → net (0,2 s), ou « pop » avec léger rebond pour les étiquettes.
- Chiffres : compteur de 1 à 1,6 s, puis immobile.
- Secousse de caméra et flash uniquement sur les impacts, 3 par vidéo au maximum.
- Transitions provoquées par un objet à l'écran (l'image devient le schéma, la carte se range dans la pièce, zoom sur la pièce concernée).
- Un titre posé ne bouge plus.

## Voix
- Kevin (ElevenLabs, modèle eleven_v4), ton enthousiaste avec les tags [excited], [curious] et [mischievously].
- Silences resserrés, débit +10 %, mêmes hauteur et timbre.
- Une respiration d'environ 0,6 s avant l'appel à l'abonnement.

## Son
- **Pas de musique**, sur toutes les plateformes. Uniquement la voix et les bruitages.
- 12 bruitages au maximum, chacun déclenché par une action visible. Tous restent nettement sous la voix et s'abaissent automatiquement quand elle parle.
- Volume final −14,5 LUFS, crête −1,5 dBFS.
- Un seul export par vidéo, le même pour TikTok, Reels et YouTube Shorts.

## Identité
- Logo : « V? », V blanc et point d'interrogation jaune (#FFD23F) sur fond noir bleuté (#0B0C12). Fichier : `kit/assets/logo.png`.

## Publication
- 3 vidéos par jour, chacune sur TikTok, Instagram Reels et YouTube Shorts.
- Horaires (heure de Bruxelles) : **9 h 00** et **19 h 00** → « Comment ça marche vraiment ? » ; **12 h 00** → « Combien ça coûte vraiment ? ».
- Les 3 vidéos sont produites la veille au soir (voir `PRODUCTION.md`), puis programmées : TikTok et YouTube via Zernio, Instagram via l'API officielle (une tâche publie le Reel à l'heure).
- Chaque publication a sa description et ses hashtags propres à la plateforme, sans mention « généré par IA » dans le texte (le label IA officiel de TikTok et YouTube reste activé).
- Budget ElevenLabs (121 000 crédits/mois) : scripts de 30 à 35 s, image IA seulement quand elle apporte vraiment (environ 1 vidéo sur 3), bruitages réutilisés depuis la bibliothèque.

## Fond
- Faits vérifiés et sources affichées sur la carte de fin.
- Une accroche qui contredit une idée reçue, un seul mécanisme expliqué en 3 ou 4 étapes, une chute qui surprend.
