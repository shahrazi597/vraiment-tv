<!doctype html>
<html lang="fr" data-resolution="portrait">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <script src="assets/gsap.min.js"></script>
    <script src="assets/da.js"></script>
    <link rel="stylesheet" href="assets/da.css" />
    <style>
      /* ---------- accroche ---------- */
      #h-t1 { top: 300px; font-size: 96px; }
      #h-stamp { top: 1095px; }
      #face { position: absolute; left: 0; top: 0; }
      #dark { position: absolute; inset: 0; background: #000; opacity: 0; }

      /* ---------- schéma ---------- */
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 290px; height: 80px; }
      #infos { top: 384px; height: 80px; }
      #nums { position: absolute; left: 230px; top: 590px; width: 620px; height: 470px; border-radius: 30px; background: var(--panel);
        border: 3px solid var(--line); opacity: 0; display: grid; grid-template-columns: repeat(5, 1fr); align-content: center; row-gap: 10px; }
      #nums span { text-align: center; font-size: 40px; font-weight: 800; color: var(--cream); opacity: 0; }
      #nums span.k { color: var(--amber); }
      .card { position: absolute; top: 560px; width: 400px; height: 330px; border-radius: 30px; background: var(--panel); border: 4px solid var(--line); opacity: 0; }
      .card .t { position: absolute; left: 0; right: 0; top: 24px; text-align: center; font-size: 30px; font-weight: 800; letter-spacing: .08em; color: var(--muted); }
      .card .g { position: absolute; left: 30px; right: 30px; top: 86px; display: grid; grid-template-columns: repeat(3, 1fr); row-gap: 10px; }
      .card .g span { text-align: center; font-size: 40px; font-weight: 800; color: var(--cream); }
      .card .ok { position: absolute; left: 0; right: 0; bottom: 18px; text-align: center; font-size: 34px; font-weight: 900; color: var(--amber); opacity: 0; }
      #cd-a { left: 90px; } #cd-b { left: 590px; }
      #eq { position: absolute; left: 490px; width: 100px; top: 670px; text-align: center; font-size: 90px; font-weight: 900; color: var(--amber); opacity: 0; }
      #lock { position: absolute; left: 0; top: 0; opacity: 0; }
      #odds { position: absolute; left: 0; right: 0; top: 520px; text-align: center; opacity: 0; }
      #odds .s { font-size: 64px; font-weight: 900; text-transform: uppercase; color: var(--cream); }
      #odds .b { font-size: 132px; font-weight: 900; letter-spacing: -.045em; line-height: 1.02; text-transform: uppercase; color: var(--amber); white-space: nowrap; }
      #tw-title { top: 300px; font-size: 100px; }
      #tw-title .wsp { opacity: 0; }
      #twins { position: absolute; left: 0; top: 0; opacity: 0; }
      #tw-stamp { top: 1040px; }
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
        <div id="dark"></div>
      </div>

      <div id="cam">
        <!-- le visage en points (accroche, étapes 1-2, bonus) -->
        <div id="s-face" class="clip" data-start="0" data-duration="%%FACE_D%%" data-track-index="1" data-track-kind="graphics">
          <svg id="face" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <defs>
              <linearGradient id="cone" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="#ff5236" stop-opacity=".45" /><stop offset="1" stop-color="#ff5236" stop-opacity="0" /></linearGradient>
              <filter id="dglw" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="16" /></filter>
            </defs>
            <ellipse id="halo" cx="540" cy="840" rx="230" ry="260" fill="#ff5236" opacity="0" filter="url(#dglw)" />
            <path id="beam" d="M508 512 L300 1030 L780 1030 Z" fill="url(#cone)" opacity="0" />
            <ellipse id="outline" cx="540" cy="840" rx="212" ry="248" fill="none" stroke="#ece6d6" stroke-width="5" stroke-dasharray="3 14" stroke-linecap="round" opacity=".35" />
            <g id="dots"></g>
            <g id="island" opacity="0">
              <rect x="420" y="482" width="240" height="56" rx="28" fill="#16161b" stroke="#ece6d6" stroke-width="4" />
              <circle id="proj" cx="508" cy="510" r="13" fill="#ff5236" />
              <circle id="lens" cx="610" cy="510" r="14" fill="#0b0b0e" stroke="#4cc4ff" stroke-width="5" />
            </g>
          </svg>
        </div>

        <!-- 1. Accroche -->
        <div id="s-hook" class="clip" data-start="0" data-duration="%%HOOK_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="h-t1" class="hl">Ton iPhone<br />te bombarde de<br /><span class="a">+30&nbsp;000</span> points</div>
          <div id="h-stamp" class="stamp"><span>Invisibles&nbsp;!</span></div>
        </div>

        <!-- 2. Les étapes -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="nums"></div>
          <div id="cd-a" class="card"><div class="t">ENREGISTRÉ</div><div class="g"></div><div class="ok">✓</div></div>
          <div id="cd-b" class="card"><div class="t">MAINTENANT</div><div class="g"></div><div class="ok">✓</div></div>
          <div id="eq">=</div>
          <svg id="lock" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <path id="shackle" d="M495 990 V950 a45 45 0 0 1 90 0 V990" fill="none" stroke="#ece6d6" stroke-width="16" stroke-linecap="round" />
            <rect id="lbody" x="465" y="985" width="150" height="120" rx="26" fill="#ffb21f" />
            <circle cx="540" cy="1038" r="13" fill="#0b0b0e" /><rect x="533" y="1040" width="14" height="34" rx="7" fill="#0b0b0e" />
          </svg>
          <div id="odds"><div class="s">Moins d'1 chance sur</div><div class="b"><span id="od">1</span></div></div>

          <div id="steps" class="row">
            <div id="st1" class="chip hot"><b>1</b>LE PROJECTEUR</div>
            <div id="st2" class="chip cold"><b>2</b>LA CAMÉRA</div>
            <div id="st3" class="chip amb"><b>3</b>LE MODÈLE</div>
            <div id="st4" class="chip amb"><b>4</b>LA COMPARAISON</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--red)"></i>Points infrarouges</div>
            <div id="in2" class="chip"><i style="background:var(--cold)"></i>Le relief décale les points</div>
            <div id="in3" class="chip"><i style="background:var(--amber)"></i>Ton visage en chiffres</div>
            <div id="in4" class="chip"><i style="background:var(--amber)"></i>Chiffré dans une zone sécurisée</div>
            <div id="in5" class="chip"><i style="background:var(--red)"></i>Il s'éclaire lui-même</div>
          </div>

          <div id="tw-title" class="hl"><span class="wsp">Et</span> <span class="wsp">ton</span><br /><span class="wsp a">jumeau&nbsp;?</span></div>
          <svg id="twins" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="tw-a" fill="none" stroke="#ece6d6" stroke-width="7" stroke-linecap="round">
              <ellipse cx="330" cy="790" rx="135" ry="170" /><circle cx="285" cy="760" r="10" fill="#ece6d6" /><circle cx="375" cy="760" r="10" fill="#ece6d6" />
              <path d="M330 775 V830 h-18" /><path d="M285 870 q45 28 90 0" />
            </g>
            <g id="tw-b" fill="none" stroke="#ffb21f" stroke-width="7" stroke-linecap="round">
              <ellipse cx="750" cy="790" rx="135" ry="170" /><circle cx="705" cy="760" r="10" fill="#ffb21f" /><circle cx="795" cy="760" r="10" fill="#ffb21f" />
              <path d="M750 775 V830 h-18" /><path d="M705 870 q45 28 90 0" />
            </g>
            <text x="540" y="820" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="90" fill="#ff5236">≈</text>
          </svg>
          <div id="tw-stamp" class="stamp"><span>Ses chances&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="4" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 6 · Face&nbsp;ID</div>
          <div id="c-src">Sources : Apple, « À propos de la technologie avancée de Face&nbsp;ID » · Apple, présentation de l'iPhone&nbsp;X (2017)</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#6</span>
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
      DA.fitCaptions(CAP);
      const tl = gsap.timeline({ paused: true });
      const D = DA(tl);
      D.drift(C.end);
      let seed = 11; const rnd = () => ((seed = (seed * 16807) % 2147483647) / 2147483647);

      // ---------- le visage : grille de points dans une ellipse, relief h(x, y) ----------
      const CX = 540, CY = 840, RX = 200, RY = 236, STEP = 21;
      const ease = (x) => (x <= 0 ? 0 : x >= 1 ? 1 : x * x * (3 - 2 * x));
      const R = (t, t0, d, a, b) => a + (b - a) * ease((t - t0) / d);
      const depth = (u, v) => { const b = Math.sqrt(Math.max(0, 1 - u * u - v * v));
        const nose = 0.55 * Math.exp(-(u * u / 0.018 + (v - 0.08) ** 2 / 0.06));
        const eyes = -0.3 * Math.exp(-(((Math.abs(u) - 0.4) ** 2) / 0.02 + (v + 0.2) ** 2 / 0.012));
        const mouth = 0.08 * Math.exp(-(u * u / 0.08 + (v - 0.5) ** 2 / 0.006));
        return Math.max(0, 0.65 * b + nose + eyes + mouth); };
      const DOTS = [], dg = document.getElementById("dots");
      for (let y = CY - RY; y <= CY + RY; y += STEP) for (let x = CX - RX; x <= CX + RX; x += STEP) {
        const u = (x - CX) / RX, v = (y - CY) / RY; if (u * u + v * v > 1) continue;
        DOTS.push({ x, y, h: depth(u, v), r: rnd(), e: mk(dg, "circle", { cx: x, cy: y, r: 5, fill: "#ff5236", opacity: 0 }) }); }
      const mix = (a, b, f) => a.map((x, i) => Math.round(x + (b[i] - x) * f));
      const RED = [255, 82, 54], COLD = [76, 196, 255], AMB = [255, 178, 31];
      const drawFace = (t) => {
        const vis = R(t, C.voient - 0.1, 0.4, 1, 0.22) + R(t, C.camera - 0.2, 0.4, 0, 0.78);      // invisible pour tes yeux, vu par la caméra
        const dfm = R(t, C.decalent - 0.25, 0.9, 0, 1);
        const col = R(t, C.relief - 0.2, 0.6, 0, 1) - R(t, C.noir - 0.2, 0.5, 0, 1);
        const out = R(t, C.transforme - 0.2, 0.5, 1, 0) + R(t, C.noir - 0.2, 0.6, 0, 1) - R(t, C.inconnu - 0.3, 0.3, 0, 1);
        DOTS.forEach((d, i) => {
          const ap = ease((t - (C.bombarde - 0.1 + 0.9 * d.r)) / 0.15);
          const o = ap * vis * out;
          const x = d.x + 34 * d.h * dfm, rr = 4 + (2.5 * d.h) * (0.4 + 0.6 * col);
          const c = mix(RED, d.h > 0.5 ? mix(COLD, AMB, (d.h - 0.5) / 0.5) : mix([60, 80, 120], COLD, d.h / 0.5), Math.max(0, col));
          d.e.setAttribute("cx", x.toFixed(1)); d.e.setAttribute("r", rr.toFixed(2));
          d.e.setAttribute("opacity", o.toFixed(3)); d.e.setAttribute("fill", `rgb(${c.join(",")})`);
        });
      };
      const clock = { t: 0 };
      tl.to(clock, { t: C.end, duration: C.end, ease: "none", onUpdate: () => drawFace(clock.t) }, 0);

      // ---------- les chiffres ----------
      const nums = document.getElementById("nums"), NUMS = [];
      for (let k = 0; k < 35; k++) { const s = document.createElement("span"); s.textContent = (rnd() * 0.98 + 0.01).toFixed(2).replace(".", ","); if (k % 7 === 3) s.className = "k"; nums.appendChild(s); NUMS.push(s); }
      const fill = (sel) => { const g = document.querySelector(sel + " .g"); let s2 = 3; const r2 = () => ((s2 = (s2 * 48271) % 2147483647) / 2147483647);
        for (let k = 0; k < 9; k++) { const s = document.createElement("span"); s.textContent = (r2() * 0.98 + 0.01).toFixed(2).replace(".", ","); g.appendChild(s); } };
      fill("#cd-a"); fill("#cd-b");

      // ================= 1. ACCROCHE =================
      D.glow("red", 0, 0.4, 0.01);
      tl.to("#halo", { opacity: 0.18, duration: 0.4 }, C.bombarde);
      D.shake(C.bombarde + 0.05, 9);
      tl.fromTo("#h-t1 .a", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.08 }, { scale: 1, duration: 0.3, ease: "expo.out" }] }, C.n30);
      D.stamp("#h-stamp span", C.invisibles, -5);
      D.flash(C.invisibles + 0.02, 0.14);
      const T1 = C.comment - 0.2;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 - 0.1, 0.16);
      tl.to("#halo", { opacity: 0, duration: 0.3 }, T1);
      D.glow("red", T1, 0.15, 0.4); D.glow("cream", T1, 0.3, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.1, 0.12); D.popIn("#st" + n, t, 0.6); };
      const info = (n, t, out) => { D.popIn("#in" + n, t, 0.5); if (out) D.blurOut("#in" + n, out, 0.15); };

      // ================= ÉTAPE 1 : le projecteur =================
      step(1, C.e1);
      tl.fromTo("#island", { opacity: 0, y: -40 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(2)" }, C.haut - 0.1);
      tl.fromTo("#proj", { scale: 1 }, { keyframes: [{ scale: 1.6, duration: 0.12 }, { scale: 1, duration: 0.3 }], svgOrigin: "508 510" }, C.projecteur);
      tl.to("#beam", { opacity: 1, duration: 0.3 }, C.envoie - 0.1);
      info(1, C.infrarouge - 0.1, C.e2 - 0.2);
      D.glow("red", C.envoie, 0.35, 0.4);
      tl.to("#beam", { opacity: 0.15, duration: 0.4 }, C.voient - 0.1);
      tl.to("#outline", { opacity: 0.6, duration: 0.3 }, C.voient - 0.1);

      // ================= ÉTAPE 2 : la caméra =================
      step(2, C.e2);
      tl.to("#beam", { opacity: 0, duration: 0.3 }, C.e2);
      tl.fromTo("#lens", { scale: 1 }, { keyframes: [{ scale: 1.6, duration: 0.12 }, { scale: 1, duration: 0.3 }, { scale: 1.4, duration: 0.1 }, { scale: 1, duration: 0.3 }], svgOrigin: "610 510" }, C.camera);
      D.glow("cold", C.camera, 0.35, 0.4); D.glow("red", C.camera, 0.15, 0.4);
      tl.to("#outline", { opacity: 0.2, duration: 0.3 }, C.filme);
      info(2, C.decalent - 0.2, C.e3 - 0.2);
      D.glow("amber", C.relief, 0.45, 0.4); D.glow("cold", C.relief, 0.25, 0.4);
      tl.fromTo("#face", { scale: 1 }, { keyframes: [{ scale: 1.04, duration: 0.12 }, { scale: 1, duration: 0.35 }], transformOrigin: "540px 840px" }, C.relief);

      // ================= ÉTAPE 3 : le modèle mathématique =================
      step(3, C.e3);
      tl.to(["#island", "#outline"], { opacity: 0, duration: 0.3 }, C.transforme - 0.2);
      tl.fromTo("#nums", { opacity: 0, scale: 0.9 }, { opacity: 1, scale: 1, duration: 0.4, ease: "expo.out" }, C.transforme);
      NUMS.forEach((s, k) => tl.to(s, { opacity: 1, duration: 0.12 }, C.transforme + 0.1 + (k % 7) * 0.05 + Math.floor(k / 7) * 0.08));
      info(3, C.modele - 0.1, C.e4 - 0.2);
      D.glow("amber", C.chiffres, 0.6, 0.3); D.glow("cold", C.chiffres, 0, 0.4);
      tl.fromTo("#nums", { scale: 1 }, { keyframes: [{ scale: 1.04, duration: 0.1 }, { scale: 1, duration: 0.3 }] }, C.chiffres);

      // ================= ÉTAPE 4 : la comparaison =================
      step(4, C.e4);
      tl.to("#nums", { x: 260, scale: 0.65, opacity: 0, duration: 0.4, ease: "power3.in" }, C.e4 - 0.1);
      tl.fromTo("#cd-b", { opacity: 0, x: 60 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.e4 + 0.2);
      tl.fromTo("#cd-a", { opacity: 0, x: -60 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.enregistre - 0.2);
      tl.to("#cd-a", { borderColor: "#4cc4ff", duration: 0.25 }, C.chiffre - 0.1);
      info(4, C.zone - 0.1, C.fou - 0.3);
      D.glow("amber", C.e4, 0.3, 0.4);
      tl.fromTo("#lock", { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(2)" }, C.securisee - 0.2);
      tl.to("#eq", { opacity: 1, duration: 0.2 }, C.colle - 0.15);
      tl.to(["#cd-a .ok", "#cd-b .ok"], { opacity: 1, duration: 0.15 }, C.colle);
      tl.to(["#cd-a", "#cd-b"], { borderColor: "#ffb21f", duration: 0.2 }, C.colle);
      tl.to("#shackle", { y: -36, duration: 0.25, ease: "back.out(2.5)" }, C.deverrouille - 0.05);
      tl.to("#shackle", { rotation: 28, svgOrigin: "585 990", duration: 0.25, ease: "power2.out" }, C.deverrouille + 0.15);
      D.flash(C.deverrouille, 0.16, "#ffb21f");
      D.shake(C.deverrouille + 0.02, 8);

      // ================= BONUS : dans le noir, 1 chance sur 1 million =================
      D.blurOut("#st4", C.fou - 0.3, 0.15);
      tl.to(["#cd-a", "#cd-b", "#eq", "#lock"], { opacity: 0, filter: "blur(10px)", duration: 0.3 }, C.fou - 0.3);
      D.glow("amber", C.fou, 0, 0.4); D.glow("cream", C.fou, 0, 0.4); D.glow("cold", C.fou, 0, 0.4);
      tl.to("#dark", { opacity: 0.75, duration: 0.5 }, C.noir - 0.3);
      tl.to("#halo", { opacity: 0.5, duration: 0.5 }, C.eclaire - 0.1);
      D.glow("red", C.eclaire, 0.5, 0.5);
      info(5, C.eclaire - 0.1, C.inconnu - 0.3);
      tl.to("#dark", { opacity: 0, duration: 0.4 }, C.inconnu - 0.3);
      tl.to("#halo", { opacity: 0, duration: 0.3 }, C.inconnu - 0.3);
      D.glow("red", C.inconnu, 0, 0.4); D.glow("amber", C.inconnu, 0.5, 0.4);
      D.blurIn("#odds", C.inconnu - 0.05);
      { const el = document.getElementById("od"); const o = { v: 1 };
        tl.to(o, { v: 1000000, duration: C.million - C.sur + 0.25, ease: "power2.out", onUpdate: () => (el.textContent = Math.round(o.v).toLocaleString("fr-FR").replace(/\s/g, " ")) }, C.sur - 0.05); }
      tl.fromTo("#odds .b", { scale: 1 }, { keyframes: [{ scale: 1.08, duration: 0.1 }, { scale: 1, duration: 0.3, ease: "expo.out" }] }, C.million + 0.25);

      // ================= LA CHUTE : le jumeau =================
      tl.to("#odds", { opacity: 0, filter: "blur(10px)", duration: 0.2 }, C.mais2 - 0.25);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.08, ease: "power2.out" }, C.mais2 - 0.15);
      tl.fromTo("#twins", { opacity: 0, y: 60 }, { opacity: 1, y: 0, duration: 0.4, ease: "back.out(1.8)" }, C.jumeau - 0.1);
      D.glow("amber", C.jumeau, 0.3, 0.4);
      D.stamp("#tw-stamp span", C.chances, -5);
      D.glow("red", C.chances, 0.5, 0.3);
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.3, ease: "power3.in" }, C.abonne - 0.32);

      // ================= CARTE DE FIN =================
      D.glow("red", C.abonne - 0.2, 0, 0.4); D.glow("amber", C.abonne - 0.2, 0, 0.4); D.glow("cold", C.abonne - 0.2, 0, 0.4);
      D.glow("cream", C.abonne - 0.2, 0.5, 0.4);
      D.endCard(C.abonne - 0.05, C.vraiment);

      D.captions(CAP);
      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
