<!doctype html>
<html lang="fr" data-resolution="portrait">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <script src="assets/gsap.min.js"></script>
    <script src="assets/da.js"></script>
    <link rel="stylesheet" href="assets/da.css" />
    <style>
      /* ---------- bulles de discussion ---------- */
      .bub { position: absolute; border-radius: 40px; background: rgba(22,22,27,.96); border: 3px solid var(--line);
        box-shadow: 0 40px 120px rgba(0,0,0,.5); }
      .stream { position: absolute; left: 54px; right: 54px; top: 46px; font-weight: 800; letter-spacing: -.02em; line-height: 1.22; text-align: left; }
      .stream .tk { display: none; }
      .cur { display: inline-block; width: .5em; height: .9em; margin-left: .08em; vertical-align: -.08em; border-radius: 6px; background: var(--amber); }

      /* ---------- accroche ---------- */
      #h-t1 { top: 300px; font-size: 86px; }
      #h-bub { left: 110px; top: 700px; width: 860px; height: 250px; }
      #h-bub .stream { font-size: 56px; }
      #h-stamp { top: 1010px; }

      /* ---------- schéma ---------- */
      #stage { position: absolute; inset: 0; }
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 290px; height: 80px; }
      #infos { top: 384px; height: 80px; }

      /* étape 1 : la question découpée */
      #q { left: 110px; top: 520px; width: 860px; height: 130px; opacity: 0; }
      #toks { position: absolute; left: 0; top: 540px; width: 1080px; height: 100px; }
      .tok { position: absolute; top: 0; height: 92px; padding: 0 22px; display: flex; align-items: center; border-radius: 22px;
        font-size: 54px; font-weight: 800; letter-spacing: -.02em; white-space: nowrap; background: #16161b; border: 4px solid transparent; }
      .tok .n { position: absolute; left: 0; right: 0; top: 118px; text-align: center; font-size: 30px; font-weight: 700; line-height: 1.32;
        color: var(--cream); opacity: 0; white-space: nowrap; }

      /* étape 2 : le modèle et les textes */
      #model { position: absolute; left: 0; top: 0; opacity: 0; }
      #pages { position: absolute; inset: 0; }
      .pg { position: absolute; left: 0; top: 0; width: 84px; height: 112px; border-radius: 10px; background: var(--cream); opacity: 0;
        box-shadow: 0 10px 30px rgba(0,0,0,.4); }
      .pg::before { content: ""; position: absolute; left: 14px; right: 14px; top: 18px; height: 70px;
        background: repeating-linear-gradient(180deg, #8e8c95 0 6px, transparent 6px 16px); opacity: .7; }

      /* étapes 3-4 : la suite la plus probable */
      #ctx { position: absolute; left: 110px; right: 110px; top: 500px; font-size: 64px; font-weight: 900; letter-spacing: -.03em; opacity: 0; white-space: nowrap; text-align: center; }
      #blank { display: inline-block; width: 190px; height: 70px; vertical-align: -10px; border-bottom: 8px solid var(--amber); margin-left: .2em; position: relative; }
      #blank b { position: absolute; left: 0; right: 0; bottom: 4px; text-align: center; color: var(--amber); opacity: 0; }
      #bars { position: absolute; left: 110px; width: 860px; top: 640px; }
      .bar { position: absolute; left: 0; width: 860px; height: 96px; opacity: 0; }
      .bar .w { position: absolute; left: 0; top: 14px; width: 170px; font-size: 52px; font-weight: 900; letter-spacing: -.02em; }
      .bar .tr { position: absolute; left: 190px; top: 24px; width: 520px; height: 50px; border-radius: 14px; background: #1d1d23; overflow: hidden; }
      .bar .fl { position: absolute; left: 0; top: 0; bottom: 0; width: 520px; border-radius: 14px; background: var(--cream); transform-origin: 0 50%; }
      .bar .p { position: absolute; left: 730px; top: 14px; width: 130px; text-align: right; font-size: 52px; font-weight: 900; letter-spacing: -.02em; }
      #b0 .fl { background: var(--amber); }
      #b0 .w, #b0 .p { color: var(--amber); }
      #ex { position: absolute; left: 0; right: 0; top: 1100px; text-align: center; font-size: 28px; font-weight: 700; color: var(--muted); opacity: 0; }
      #pick { position: absolute; left: 110px; top: 654px; width: 170px; font-size: 52px; font-weight: 900; color: var(--amber); opacity: 0; letter-spacing: -.02em; }
      #more { position: absolute; left: 110px; right: 110px; top: 610px; font-size: 50px; font-weight: 800; letter-spacing: -.02em; line-height: 1.25; text-align: center; }
      #more .tk { opacity: 0; display: inline-block; }
      #loop { position: absolute; left: 470px; top: 930px; width: 140px; height: 140px; opacity: 0; }

      #topshade { position: absolute; left: 0; right: 0; top: 0; height: 480px; opacity: 0;
        background: linear-gradient(180deg, rgba(11,11,14,1) 0%, rgba(11,11,14,.94) 62%, rgba(11,11,14,0) 100%); }
      #capshade { position: absolute; left: 0; right: 0; top: 1120px; height: 800px; opacity: 0;
        background: linear-gradient(180deg, rgba(11,11,14,0) 0%, rgba(11,11,14,.92) 9%, rgba(11,11,14,.97) 100%); }

      /* chute */
      #tw-title { top: 300px; font-size: 96px; }
      #tw-title .wsp { opacity: 0; }
      #tw-stamp { top: 330px; }
      #chat { left: 110px; top: 560px; width: 860px; height: 520px; opacity: 0; }
      #chat .ask { position: absolute; right: 40px; top: 40px; padding: 18px 30px; border-radius: 28px; background: #23232a; font-size: 36px; font-weight: 800; color: var(--cream); }
      #chat .stream { top: 150px; font-size: 46px; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-duration="%%END%%" data-width="1080" data-height="1920">
%%AUDIO%%

      <div id="bg" class="clip" data-start="0" data-duration="%%END%%" data-track-index="0" data-track-kind="graphics">
        <div id="grid"></div>
        <div id="gl-cream" class="glow"></div>
        <div id="gl-red" class="glow"></div>
        <div id="gl-amber" class="glow"></div>
        <div id="gl-cold" class="glow"></div>
        <div id="vign"></div>
      </div>

      <div id="cam">
        <!-- 1. Accroche -->
        <div id="s-hook" class="clip" data-start="0" data-duration="%%HOOK_D%%" data-track-index="1" data-track-kind="graphics">
          <div id="h-t1" class="hl">ChatGPT ne connaît<br />pas sa réponse<br /><span class="a">à l'avance.</span></div>
          <div id="h-bub" class="bub">
            <div class="stream"><span class="t0">Le</span> <span class="t0">ciel</span> <span class="tk">est</span> <span class="tk">bleu</span> <span class="tk">parce</span> <span class="tk">que</span><span id="h-cur" class="cur"></span></div>
          </div>
          <div id="h-stamp" class="stamp"><span>Mot par mot&nbsp;!</span></div>
        </div>

        <!-- 2. Le mécanisme -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="stage">
            <!-- étape 1 -->
            <div id="q" class="bub"></div>
            <div id="toks"></div>

            <!-- étape 2 -->
            <svg id="model" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <rect x="250" y="590" width="580" height="420" rx="44" fill="#121217" stroke="#ece6d6" stroke-width="6" />
              <g id="links" stroke="#2f2f38" stroke-width="3"></g>
              <g id="nodes"></g>
              <text x="540" y="1062" text-anchor="middle" font-family="Inter Display" font-weight="800" font-size="34" letter-spacing="5" fill="#8e8c95">LE MODÈLE</text>
            </svg>
            <div id="pages"></div>

            <!-- étapes 3-4 -->
            <div id="ctx">Le ciel est<span id="blank"><b>bleu</b></span></div>
            <div id="bars">
              <div id="b0" class="bar" style="top:0px"><div class="w">bleu</div><div class="tr"><div class="fl"></div></div><div class="p"><span id="p0">0</span>&nbsp;%</div></div>
              <div id="b1" class="bar" style="top:110px"><div class="w">gris</div><div class="tr"><div class="fl"></div></div><div class="p"><span id="p1">0</span>&nbsp;%</div></div>
              <div id="b2" class="bar" style="top:220px"><div class="w">beau</div><div class="tr"><div class="fl"></div></div><div class="p"><span id="p2">0</span>&nbsp;%</div></div>
              <div id="b3" class="bar" style="top:330px"><div class="w">noir</div><div class="tr"><div class="fl"></div></div><div class="p"><span id="p3">0</span>&nbsp;%</div></div>
            </div>
            <div id="ex">Probabilités données pour l'exemple</div>
            <div id="pick">bleu</div>
            <div id="more"><span class="tk">parce</span> <span class="tk">que</span> <span class="tk">l'air</span> <span class="tk">diffuse</span> <span class="tk">surtout</span> <span class="tk">la</span> <span class="tk">lumière</span> <span class="tk">bleue</span> <span class="tk">du</span> <span class="tk">Soleil…</span></div>
            <svg id="loop" width="140" height="140" viewBox="0 0 140 140" aria-hidden="true">
              <path d="M110 70 a40 40 0 1 1 -12 -28.5" fill="none" stroke="#ffb21f" stroke-width="12" stroke-linecap="round" />
              <path d="M84 26 l26 6 l-8 26" fill="none" stroke="#ffb21f" stroke-width="12" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </div>

          <div id="capshade"></div>
          <div id="topshade"></div>

          <div id="steps" class="row">
            <div id="st1" class="chip cold" style="position:absolute"><b>1</b>DÉCOUPAGE</div>
            <div id="st2" class="chip amb" style="position:absolute"><b>2</b>ENTRAÎNEMENT</div>
            <div id="st3" class="chip cold" style="position:absolute"><b>3</b>PROBABILITÉS</div>
            <div id="st4" class="chip hot" style="position:absolute"><b>4</b>TIRAGE</div>
          </div>
          <div id="infos" class="row">
            <div id="in0" class="chip" style="position:absolute"><i style="background:var(--cold)"></i>1 token = un bout de mot</div>
            <div id="in1" class="chip" style="position:absolute"><i style="background:var(--cream)"></i>Des montagnes de textes</div>
            <div id="in2" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>« le ciel est… » → « bleu »</div>
            <div id="in3" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Un morceau à la fois, en boucle</div>
          </div>

          <div id="tw-title" class="hl"><span class="wsp">Ça</span> <span class="wsp">s'affiche</span><br /><span class="wsp a">petit</span> <span class="wsp a">à</span> <span class="wsp a">petit</span></div>
          <div id="tw-stamp" class="stamp"><span>En temps réel&nbsp;!</span></div>
          <div id="chat" class="bub">
            <div class="ask">Pourquoi le ciel est bleu&nbsp;?</div>
            <div class="stream" id="ans"></div>
          </div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 2 · Une IA comme ChatGPT</div>
          <div id="c-src">Sources : Télécom SudParis (cours « Modèles de langage ») · Université de Washington, « Language Models: A Guide for the Perplexed » (2023)</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#2</span>
      </div>

      <div id="fx" class="clip" data-start="0" data-duration="%%END%%" data-track-index="7" data-track-kind="graphics">
        <div id="flash"></div>
      </div>
    </div>

    <script>
      const C = %%CUES%%;
      const CAP = %%CAPDATA%%;
      const NS = "http://www.w3.org/2000/svg";
      const mk = (parent, tag, attrs) => { const e = document.createElementNS(NS, tag); for (const k in attrs) e.setAttribute(k, attrs[k]); parent.appendChild(e); return e; };
      const div = (parent, cls, html = "") => { const e = document.createElement("div"); e.className = cls; e.innerHTML = html; parent.appendChild(e); return e; };
      DA.fitCaptions(CAP);
      const tl = gsap.timeline({ paused: true });
      const D = DA(tl);
      D.drift(C.end);

      // ================= 1. ACCROCHE : une réponse qui s'écrit =================
      D.glow("amber", 0, 0.45, 0.01);
      tl.fromTo("#h-bub", { y: 30 }, { y: 0, duration: 0.5, ease: "expo.out" }, 0);
      { const tks = gsap.utils.toArray("#h-bub .tk"); const t0 = 0.5, t1 = C.devine - 0.1;
        tks.forEach((e, j) => { const t = t0 + j * (t1 - t0) / tks.length; tl.set(e, { display: "inline" }, t);
          tl.fromTo(e, { opacity: 0, filter: "blur(6px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.12 }, t); }); }
      tl.to("#h-cur", { opacity: 0.15, duration: 0.01, repeat: 9, yoyo: true, repeatDelay: 0.22 }, 0.1);
      // « mot par mot » : chaque mot s'allume tour à tour
      gsap.utils.toArray("#h-bub .t0, #h-bub .tk").forEach((e, j) => tl.to(e, { keyframes: [{ color: "#ffb21f", duration: 0.05 }, { color: "#f6f4ee", duration: 0.25 }] }, C.mot - 0.1 + j * 0.1));
      D.stamp("#h-stamp span", C.mot, -5);
      D.shake(C.mot + 0.02, 10);
      D.glow("red", C.mot, 0.5, 0.3);

      // la bulle devient la question
      const T1 = C.e1 - 0.25;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 - 0.1, 0.18);
      tl.to("#h-bub", { y: -180, scale: 0.9, opacity: 0, filter: "blur(10px)", duration: 0.32, ease: "power3.in" }, T1 - 0.05);
      D.glow("red", T1, 0, 0.4); D.glow("amber", T1, 0, 0.4); D.glow("cold", T1, 0.5, 0.4);
      tl.fromTo("#stage", { opacity: 0, filter: "blur(12px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.4, ease: "expo.out" }, T1 + 0.1);
      tl.to("#capshade", { opacity: 1, duration: 0.3 }, T1 + 0.1);
      tl.to("#topshade", { opacity: 1, duration: 0.3 }, T1 + 0.1);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.1, 0.12); D.popIn("#st" + n, t, 0.6); };

      // ================= ÉTAPE 1 — DÉCOUPAGE EN TOKENS =================
      step(1, C.e1);
      const TOK = ["Pour", "quoi", "le", "ciel", "est", "bleu", "?"];
      const COL = ["#4cc4ff", "#ffb21f", "#ece6d6", "#4cc4ff", "#ffb21f", "#ece6d6", "#4cc4ff"];
      const NUM = [["0,21", "−0,87", "0,54"], ["−0,33", "0,12", "0,98"], ["0,77", "−0,05", "−0,61"], ["0,40", "0,93", "−0,18"],
                   ["−0,72", "0,26", "0,09"], ["0,58", "−0,44", "0,81"], ["0,03", "0,66", "−0,29"]];
      const toksEl = document.getElementById("toks");
      const TE = TOK.map((w, j) => { const e = div(toksEl, "tok", w + `<div class="n">${NUM[j].join("<br>")}</div>`); e.style.borderColor = COL[j]; return e; });
      // positions : collées (comme dans la phrase) puis écartées
      const W = TE.map((e) => e.getBoundingClientRect().width);
      const gap = 16, spaceW = [0, 0, 14, 14, 14, 14, 14];
      const tot = W.reduce((a, b) => a + b, 0) + gap * (TE.length - 1);
      let xs = [], x = (1080 - tot) / 2; W.forEach((w) => { xs.push(x); x += w + gap; });
      const joinedTot = W.reduce((a, b) => a + b, 0) + spaceW.reduce((a, b) => a + b, 0);
      let xj = [], x2 = (1080 - joinedTot) / 2; W.forEach((w, j) => { x2 += spaceW[j]; xj.push(x2); x2 += w; });
      TE.forEach((e, j) => gsap.set(e, { x: xj[j], opacity: 0, backgroundColor: "rgba(22,22,27,0)", borderColor: "rgba(0,0,0,0)" }));
      tl.fromTo("#q", { opacity: 0, scale: 0.92 }, { opacity: 1, scale: 1, duration: 0.3, ease: "expo.out" }, C.question - 0.25);
      tl.to(TE, { opacity: 1, duration: 0.2, stagger: 0.04 }, C.question - 0.15);
      // la question se découpe
      tl.to("#q", { opacity: 0, scale: 1.04, duration: 0.25 }, C.decoupee);
      TE.forEach((e, j) => tl.to(e, { x: xs[j], backgroundColor: "#16161b", borderColor: COL[j], duration: 0.45, ease: "back.out(1.8)" }, C.morceaux - 0.1 + j * 0.03));
      tl.fromTo(TE, { y: 0 }, { keyframes: [{ y: -14, duration: 0.12 }, { y: 0, duration: 0.3, ease: "bounce.out" }], stagger: 0.05 }, C.morceaux + 0.1);
      D.popIn("#in0", C.tokens - 0.05, 0.5);
      D.glow("cold", C.tokens, 0.7, 0.4);
      // chacun devient des nombres
      TE.forEach((e, j) => tl.fromTo(e.querySelector(".n"), { opacity: 0, y: -20, filter: "blur(6px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.25, ease: "power2.out" }, C.chacun + 0.05 + j * 0.08));
      tl.to(TE.map((e) => e.querySelector(".n")), { color: "#ffb21f", duration: 0.2, stagger: 0.04 }, C.nombres);
      tl.to(TE.map((e) => e.querySelector(".n")), { color: "#ece6d6", duration: 0.4, stagger: 0.04 }, C.nombres + 0.4);

      // ================= ÉTAPE 2 — ENTRAÎNEMENT : DES MONTAGNES DE TEXTES =================
      D.blurOut("#in0", C.e2 - 0.2, 0.15);
      tl.to("#toks", { y: -160, scale: 0.6, transformOrigin: "540px 0px", opacity: 0, filter: "blur(8px)", duration: 0.4, ease: "power3.in" }, C.e2 - 0.25);
      step(2, C.e2);
      D.glow("cold", C.e2, 0.2, 0.4); D.glow("cream", C.e2, 0.5, 0.4);
      // le réseau : colonnes de neurones
      const COLS = [[340, [680, 760, 840, 920]], [470, [650, 730, 810, 890, 950]], [610, [650, 730, 810, 890, 950]], [740, [680, 760, 840, 920]]];
      const links = document.getElementById("links"), nodesG = document.getElementById("nodes"), NODES = [];
      COLS.forEach(([cx, ys], c) => { if (c < COLS.length - 1) ys.forEach((y) => COLS[c + 1][1].forEach((y2) => mk(links, "line", { x1: cx, y1: y, x2: COLS[c + 1][0], y2 }))); });
      COLS.forEach(([cx, ys]) => ys.forEach((y) => NODES.push(mk(nodesG, "circle", { cx, cy: y, r: 20, fill: "#1d1d23", stroke: "#ece6d6", "stroke-width": 4 }))));
      tl.fromTo("#model", { opacity: 0, scale: 0.9, transformOrigin: "540px 800px" }, { opacity: 1, scale: 1, duration: 0.4, ease: "expo.out" }, C.pendant - 0.1);
      D.popIn("#in1", C.montagnes - 0.1, 0.5);
      // les pages qui arrivent de partout et s'engouffrent dans le modèle
      { const pages = document.getElementById("pages");
        const FROM = [[-120, 480], [1120, 560], [-120, 900], [1120, 980], [-100, 1100], [1100, 420], [-120, 680], [1120, 760], [-110, 560], [1110, 880], [-120, 1000], [1120, 640], [-110, 800], [1110, 1060]];
        FROM.forEach(([fx, fy], j) => { const p = div(pages, "pg"); const t = C.lu - 0.1 + j * ((C.apprendre - C.lu) / FROM.length);
          tl.fromTo(p, { x: fx, y: fy, rotation: (j % 2 ? 1 : -1) * (10 + j * 3), opacity: 0, scale: 1 },
            { keyframes: [{ opacity: 1, duration: 0.08 }, { x: 498, y: 744, rotation: 0, scale: 0.3, duration: 0.6, ease: "power2.in" }, { opacity: 0, duration: 0.08 }] }, t); }); }
      // les neurones s'allument au fil des pages
      NODES.forEach((n, j) => tl.to(n, { attr: { fill: j % 3 ? "#4cc4ff" : "#ffb21f" }, duration: 0.2 }, C.lu + 0.4 + (j % 9) * 0.22 + Math.floor(j / 9) * 0.1));
      tl.to("#links", { attr: { stroke: "#3e5f72" }, duration: 0.8 }, C.textes);
      D.blurOut("#in1", C.apprendre - 0.2, 0.15);
      D.popIn("#in2", C.apprendre, 0.5);
      D.glow("amber", C.apres, 0.45, 0.4);

      // ================= ÉTAPE 3 — UNE PROBABILITÉ POUR CHAQUE MORCEAU =================
      tl.to("#model", { opacity: 0, scale: 0.85, filter: "blur(8px)", duration: 0.35, ease: "power3.in" }, C.e3 - 0.25);
      D.blurOut("#in2", C.e3 - 0.2, 0.15);
      step(3, C.e3);
      D.glow("cream", C.e3, 0.2, 0.4); D.glow("amber", C.e3, 0.6, 0.4);
      D.blurIn("#ctx", C.e3 + 0.1, 0.25);
      tl.fromTo("#blank", { scaleX: 0, transformOrigin: "0 50%" }, { scaleX: 1, duration: 0.35, ease: "expo.out" }, C.e3 + 0.25);
      const PCT = [71, 12, 9, 3];
      PCT.forEach((p, j) => { const t = C.chaque - 0.1 + j * 0.16;
        tl.fromTo("#b" + j, { opacity: 0, x: -40 }, { opacity: 1, x: 0, duration: 0.3, ease: "expo.out" }, t);
        tl.fromTo(`#b${j} .fl`, { scaleX: 0 }, { scaleX: p / 100, duration: 1.1, ease: "power2.out" }, C.calcule - 0.2 + j * 0.06);
        D.count("p" + j, 0, p, C.calcule - 0.2 + j * 0.06, 1.1, 0); });
      tl.to("#ex", { opacity: 1, duration: 0.3 }, C.probabilite);

      // ================= ÉTAPE 4 — IL EN TIRE UN, L'AJOUTE… ET RECOMMENCE =================
      step(4, C.e4);
      D.glow("red", C.e4, 0.35, 0.4);
      tl.to(["#b1", "#b2", "#b3"], { opacity: 0.3, duration: 0.3 }, C.tire - 0.1);
      tl.fromTo("#b0", { scale: 1 }, { keyframes: [{ scale: 1.06, duration: 0.1 }, { scale: 1, duration: 0.3, ease: "expo.out" }] }, C.tire - 0.05);
      tl.set("#pick", { opacity: 1 }, C.tire + 0.05);
      { const bl = document.getElementById("blank"); const r = bl.getBoundingClientRect();
        tl.to("#pick", { x: r.left + 10 - 110, y: r.top + 2 - 654, duration: 0.55, ease: "power3.inOut" }, C.tire + 0.1); }
      tl.set("#pick", { opacity: 0 }, C.lajoute - 0.05);
      tl.set("#blank b", { opacity: 1 }, C.lajoute - 0.05);
      tl.fromTo("#blank", { scale: 1 }, { keyframes: [{ scale: 1.15, duration: 0.1 }, { scale: 1, duration: 0.3, ease: "expo.out" }] }, C.lajoute - 0.05);
      tl.to("#blank", { borderBottomColor: "rgba(255,178,31,0)", duration: 0.3 }, C.phrase);
      D.blurOut(["#bars", "#ex"], C.phrase - 0.1, 0.2);
      // la phrase continue, morceau par morceau
      tl.fromTo("#loop", { opacity: 0, scale: 0.5, transformOrigin: "70px 70px" }, { opacity: 1, scale: 1, duration: 0.3, ease: "back.out(2)" }, C.recommence - 0.15);
      tl.to("#loop", { rotation: 720, duration: C.cest - C.recommence, ease: "power1.inOut" }, C.recommence - 0.1);
      D.popIn("#in3", C.recommence, 0.5);
      { const tks = gsap.utils.toArray("#more .tk"), t0 = C.recommence + 0.1, t1 = C.reponse2 + 0.25;
        tks.forEach((e, j) => tl.fromTo(e, { opacity: 0, y: 12 }, { opacity: 1, y: 0, duration: 0.12, ease: "power2.out" }, t0 + j * (t1 - t0) / tks.length)); }
      D.glow("red", C.centaines, 0, 0.4);

      // ================= 5. LA CHUTE : ÇA S'ÉCRIT PENDANT QUE TU LIS =================
      D.blurOut(["#ctx", "#more", "#loop", "#in3", "#st4"], C.cest - 0.2, 0.18);
      tl.to("#topshade", { opacity: 0, duration: 0.3 }, C.cest - 0.2);
      D.glow("cream", C.cest, 0.3, 0.4); D.glow("amber", C.cest, 0.55, 0.4);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.1, ease: "power2.out" }, C.cest);
      tl.fromTo("#chat", { opacity: 0, y: 60 }, { opacity: 1, y: 0, duration: 0.4, ease: "expo.out" }, C.cest + 0.1);
      { const ANS = "Le ciel est bleu parce que l'air diffuse surtout la lumière bleue du Soleil, bien plus que la rouge.".split(" ");
        const ans = document.getElementById("ans");
        ans.innerHTML = ANS.map((w) => `<span class="tk">${w}</span>`).join(" ") + '<span id="a-cur" class="cur"></span>';
        const tks = gsap.utils.toArray("#ans .tk"), t0 = C.saffiche, t1 = C.abonne - 0.5;
        tks.forEach((e, j) => tl.set(e, { display: "inline" }, t0 + j * (t1 - t0) / tks.length));
        tl.fromTo("#a-cur", { opacity: 1 }, { opacity: 0.2, duration: 0.01, repeat: 7, yoyo: true, repeatDelay: 0.2 }, C.cest + 0.3); }
      D.blurOut("#tw-title", C.lis - 0.14, 0.12);
      D.stamp("#tw-stamp span", C.lis, -5);
      D.shake(C.lis + 0.02, 12);
      D.flash(C.lis + 0.02, 0.18, "#ffb21f");
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.3, ease: "power3.in" }, C.abonne - 0.32);
      tl.to("#capshade", { opacity: 0, duration: 0.2 }, C.abonne - 0.32);

      // ================= 6. CARTE DE FIN =================
      D.glow("amber", C.abonne - 0.2, 0, 0.4); D.glow("cream", C.abonne - 0.2, 0.5, 0.4);
      D.endCard(C.abonne - 0.05, C.vraiment);

      D.captions(CAP);
      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
