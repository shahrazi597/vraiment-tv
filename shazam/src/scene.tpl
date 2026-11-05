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
      #h-t2 { top: 300px; font-size: 100px; }
      #h-t2 .wsp { opacity: 0; }
      #h-stamp { top: 525px; }
      #hk { position: absolute; left: 0; top: 0; }

      /* ---------- schéma ---------- */
      #stage { position: absolute; inset: 0; }
      #stage svg { position: absolute; left: 0; top: 0; }
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 290px; height: 80px; }
      #infos { top: 384px; height: 80px; }
      .ax { position: absolute; font-size: 28px; font-weight: 800; letter-spacing: .08em; color: var(--muted); opacity: 0; white-space: nowrap; }
      #ax-t { left: 110px; top: 1082px; }
      #ax-a { left: 30px; top: 500px; }
      #ax-g { left: 30px; top: 1040px; }
      .song { position: absolute; left: 110px; width: 860px; height: 118px; border-radius: 26px; background: var(--panel);
        border: 3px solid var(--line); opacity: 0; }
      .song .nm { position: absolute; left: 26px; top: 14px; font-size: 28px; font-weight: 800; letter-spacing: .06em; color: var(--muted); }
      .song .res { position: absolute; right: 26px; top: 12px; font-size: 30px; font-weight: 900; opacity: 0; }
      #so-a { top: 640px; } #so-b { top: 790px; } #so-c { top: 940px; }
      #ex-lab { position: absolute; left: 110px; top: 484px; font-size: 28px; font-weight: 800; letter-spacing: .08em; color: var(--amber); opacity: 0; }
      #pct { position: absolute; left: 0; right: 0; top: 470px; text-align: center; font-size: 170px; font-weight: 900; letter-spacing: -.05em;
        color: var(--amber); line-height: 1; opacity: 0; white-space: nowrap; }
      #tw-title { top: 300px; font-size: 96px; }
      #tw-title .wsp { opacity: 0; }
      #tw-stamp { top: 1030px; }
      .vlab { position: absolute; left: 110px; font-size: 30px; font-weight: 800; letter-spacing: .06em; opacity: 0; white-space: nowrap; }
      #vl-s { top: 560px; color: var(--cream); }
      #vl-l { top: 790px; color: var(--amber); }
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
          <svg id="hk" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <defs><filter id="hsoft" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="22" /></filter></defs>
            <g id="phone">
              <ellipse cx="540" cy="860" rx="200" ry="200" fill="#4cc4ff" opacity=".22" filter="url(#hsoft)" />
              <rect x="420" y="660" width="240" height="430" rx="42" fill="#121217" stroke="#ece6d6" stroke-width="6" />
              <circle cx="540" cy="860" r="74" fill="#4cc4ff" />
              <g fill="#0b0b0e"><rect x="500" y="836" width="14" height="48" rx="7" /><rect x="524" y="816" width="14" height="88" rx="7" /><rect x="548" y="826" width="14" height="68" rx="7" /><rect x="572" y="844" width="14" height="32" rx="7" /></g>
              <g id="waves" fill="none" stroke="#4cc4ff" stroke-width="8" stroke-linecap="round">
                <path class="wv" d="M330 790 q -40 70 0 140" /><path class="wv" d="M290 760 q -60 100 0 200" /><path class="wv" d="M250 730 q -80 130 0 260" />
                <path class="wv" d="M750 790 q 40 70 0 140" /><path class="wv" d="M790 760 q 60 100 0 200" /><path class="wv" d="M830 730 q 80 130 0 260" />
              </g>
            </g>
            <g id="fp" fill="none" stroke="#ffb21f" stroke-width="9" stroke-linecap="round"></g>
          </svg>
          <div id="h-t1" class="hl">Shazam n'écoute<br />pas ta <span class="c">chanson.</span></div>
          <div id="h-t2" class="hl"><span class="wsp">Il</span> <span class="wsp">relève</span> <span class="wsp">ses</span><br /><span class="wsp a">empreintes&nbsp;!</span></div>
          <div id="h-stamp" class="stamp"><span>Jamais.</span></div>
        </div>

        <!-- 2. Le schéma : la carte du son -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="ex-lab">TON EXTRAIT</div>
          <div id="so-a" class="song"><div class="nm">CHANSON A</div><div class="res" style="color:var(--red)">✕</div></div>
          <div id="so-b" class="song"><div class="nm">CHANSON B</div><div class="res" style="color:var(--red)">✕</div></div>
          <div id="so-c" class="song"><div class="nm">CHANSON C</div><div class="res" style="color:var(--amber)">TROUVÉE&nbsp;!</div></div>
          <div id="stage">
            <svg width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <defs><filter id="glw" x="-100%" y="-100%" width="300%" height="300%"><feGaussianBlur stdDeviation="6" /></filter></defs>
              <rect id="mapframe" x="104" y="494" width="872" height="582" rx="18" fill="none" stroke="#2a2a32" stroke-width="3" opacity="0" />
              <g id="cells"></g>
              <rect id="zone" fill="#ffb21f" fill-opacity=".08" stroke="#ffb21f" stroke-width="4" stroke-dasharray="14 10" rx="10" opacity="0" />
              <g id="links" stroke="#ece6d6" stroke-width="3" stroke-linecap="round"></g>
              <g id="pair" stroke="#ffb21f" stroke-width="7" stroke-linecap="round" fill="none"></g>
              <g id="stars"></g>
              <line id="playhead" x1="110" y1="494" x2="110" y2="1076" stroke="#4cc4ff" stroke-width="6" opacity="0" />
              <g id="dt" opacity="0" stroke="#ece6d6" stroke-width="4" fill="none"></g>
              <g id="songdots"></g>
              <g id="ghost"></g>
              <g id="codes"></g>
              <g id="live"></g>
            </svg>
          </div>
          <div id="ax-t" class="ax">TEMPS →</div>
          <div id="ax-a" class="ax">AIGUS</div>
          <div id="ax-g" class="ax">GRAVES</div>

          <div id="pct"><span id="pct-n">100</span>&nbsp;%</div>

          <div id="steps" class="row">
            <div id="st1" class="chip cold"><b>1</b>LA CARTE DU SON</div>
            <div id="st2" class="chip amb"><b>2</b>LES ÉTOILES</div>
            <div id="st3" class="chip amb"><b>3</b>LES CODES</div>
            <div id="st4" class="chip hot"><b>4</b>LA RECHERCHE</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--cold)"></i>Quelques secondes de son</div>
            <div id="in2" class="chip"><i style="background:var(--amber)"></i>Seuls les points les plus forts</div>
            <div id="in3" class="chip"><i style="background:var(--amber)"></i>2 notes + l'écart = 1 code</div>
            <div id="in4" class="chip"><i style="background:var(--red)"></i>Même ordre, même rythme</div>
            <div id="in5" class="chip"><i style="background:var(--amber)"></i>1 à 2 % des codes suffisent</div>
          </div>

          <div id="vl-s" class="vlab">L'ENREGISTREMENT</div>
          <div id="vl-l" class="vlab">LA VERSION LIVE</div>
          <div id="tw-title" class="hl"><span class="wsp">Et</span> <span class="wsp">en</span> <span class="wsp c">concert&nbsp;?</span></div>
          <div id="tw-stamp" class="stamp"><span>Autre empreinte&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 4 · Shazam</div>
          <div id="c-src">Sources : A. Wang (cofondateur de Shazam), « An Industrial-Strength Audio Search Algorithm », ISMIR 2003 · Université Columbia</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#4</span>
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

      // hasard reproductible
      let seed = 7; const rnd = () => ((seed = (seed * 16807) % 2147483647) / 2147483647);

      // ================= données : la carte temps × fréquence =================
      const X0 = 110, Y0 = 500, W = 860, H = 570, NC = 40, NR = 24, CW = W / NC, RH = H / NR;
      const V = [];
      for (let c = 0; c < NC; c++) { V.push([]); for (let r = 0; r < NR; r++) {
        const band = Math.exp(-((r - 5 - 3 * Math.sin(c * 0.45)) ** 2) / 6) * 0.8 + Math.exp(-((r - 13 - 2 * Math.cos(c * 0.3)) ** 2) / 5) * 0.6
          + Math.exp(-((r - 19) ** 2) / 4) * 0.4 * (c % 4 < 2 ? 1 : 0.3);
        V[c].push(Math.min(1, 0.18 + 0.55 * rnd() * rnd() + band * (0.5 + 0.6 * rnd()))); } }
      // les étoiles : maximum local sur 5 × 5 au-dessus d'un seuil
      const PK = [];
      for (let c = 0; c < NC; c++) for (let r = 0; r < NR; r++) { let mx = true;
        for (let dc = -2; dc <= 2 && mx; dc++) for (let dr = -2; dr <= 2; dr++) { const cc = c + dc, rr = r + dr;
          if ((dc || dr) && cc >= 0 && cc < NC && rr >= 0 && rr < NR && V[cc][rr] >= V[c][r]) { mx = false; break; } }
        if (mx && V[c][r] > 0.55) PK.push({ c, r, x: X0 + (c + 0.5) * CW, y: Y0 + H - (r + 0.5) * RH }); }
      PK.sort((a, b) => a.x - b.x);
      const col = (v) => { const a = [26, 26, 33], b = [76, 196, 255], m = [236, 230, 214];
        const t = Math.min(1, v); const [p, q, f] = t < 0.6 ? [a, b, t / 0.6] : [b, m, (t - 0.6) / 0.4];
        return `rgb(${p.map((x, i) => Math.round(x + (q[i] - x) * f)).join(",")})`; };
      const cellsG = document.getElementById("cells"), CELLS = [];
      for (let c = 0; c < NC; c++) { const colG = mk(cellsG, "g", { opacity: 0 }); CELLS.push(colG);
        for (let r = 0; r < NR; r++) mk(colG, "rect", { x: (X0 + c * CW + 1.5).toFixed(1), y: (Y0 + H - (r + 1) * RH + 1.5).toFixed(1),
          width: (CW - 3).toFixed(1), height: (RH - 3).toFixed(1), rx: 3, fill: col(V[c][r]) }); }
      const starsG = document.getElementById("stars");
      const STARS = PK.map((p) => { const g = mk(starsG, "g", { opacity: 0 });
        mk(g, "circle", { cx: p.x, cy: p.y, r: 16, fill: "#ffb21f", opacity: 0.55, filter: "url(#glw)" });
        mk(g, "circle", { cx: p.x, cy: p.y, r: 9, fill: "#ffb21f" }); return g; });
      gsap.set(STARS, { transformOrigin: "50% 50%" });

      // ================= 1. ACCROCHE =================
      D.glow("cold", 0, 0.5, 0.01);
      gsap.utils.toArray("#waves .wv").forEach((w, j) => tl.fromTo(w, { opacity: 0.15 }, { opacity: 1, duration: 0.3, yoyo: true, repeat: 5, ease: "sine.inOut" }, (j % 3) * 0.12));
      D.stamp("#h-stamp span", C.jamais, -5);
      D.shake(C.jamais + 0.02, 10);
      D.flash(C.jamais + 0.02, 0.16);
      D.blurOut(["#h-t1", "#h-stamp span"], C.il - 0.12, 0.14);
      tl.fromTo("#h-t2 .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.1, ease: "power2.out" }, C.il);
      // le téléphone devient une empreinte
      tl.to("#phone", { opacity: 0, scale: 0.8, svgOrigin: "540 860", duration: 0.3, ease: "power3.in" }, C.empreintes - 0.25);
      { const fp = document.getElementById("fp"), arcs = [];
        for (let k = 0; k < 9; k++) { const rx = 40 + k * 26, ry = 56 + k * 30, gap = 0.18 + (k % 3) * 0.07;
          const a0 = -Math.PI * (0.5 + gap), a1 = Math.PI * (1.5 - gap);
          const pts = []; for (let a = a0; a <= a1; a += 0.08) pts.push(`${(540 + rx * Math.cos(a)).toFixed(1)},${(880 + ry * Math.sin(a) * (a > Math.PI * 0.2 && a < Math.PI * 0.8 ? 0.82 : 1)).toFixed(1)}`);
          const pl = mk(fp, "polyline", { points: pts.join(" "), opacity: 0 }); arcs.push(pl); }
        arcs.forEach((pl, j) => { const L = 2 * Math.PI * (40 + j * 28) * 1.1; pl.style.strokeDasharray = L; pl.style.strokeDashoffset = L;
          tl.to(pl, { opacity: 1, duration: 0.05 }, C.empreintes - 0.1 + j * 0.05);
          tl.to(pl, { strokeDashoffset: 0, duration: 0.7, ease: "power2.out" }, C.empreintes - 0.1 + j * 0.05); }); }
      D.glow("cold", C.empreintes, 0, 0.4); D.glow("amber", C.empreintes, 0.6, 0.4);
      tl.fromTo("#fp", { scale: 1 }, { keyframes: [{ scale: 1.06, duration: 0.08 }, { scale: 1, duration: 0.12, ease: "expo.out" }], svgOrigin: "540 880" }, C.police - 0.05);
      // l'empreinte devient la carte
      const T1 = C.comment - 0.2;
      D.blurOut("#h-t2", T1 - 0.1, 0.18);
      tl.to("#fp", { scale: 2.4, opacity: 0, svgOrigin: "540 880", duration: 0.35, ease: "power3.in" }, T1 - 0.1);
      tl.fromTo("#stage", { opacity: 0, scale: 0.94, transformOrigin: "540px 790px", filter: "blur(12px)" }, { opacity: 1, scale: 1, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, T1 + 0.05);
      D.glow("amber", T1, 0, 0.4); D.glow("cream", T1, 0.4, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.1, 0.12); D.popIn("#st" + n, t, 0.6); };
      const info = (n, t, out) => { D.popIn("#in" + n, t, 0.5); if (out) D.blurOut("#in" + n, out, 0.15); };

      // ================= ÉTAPE 1 : la carte =================
      step(1, C.e1);
      tl.to("#mapframe", { opacity: 1, duration: 0.3 }, C.e1);
      info(1, C.transforme - 0.1, C.e2 - 0.2);
      tl.set("#playhead", { opacity: 1 }, C.transforme);
      tl.fromTo("#playhead", { attr: { x1: X0, x2: X0 } }, { attr: { x1: X0 + W, x2: X0 + W }, duration: C.temps - C.transforme + 0.4, ease: "none" }, C.transforme);
      tl.to("#playhead", { opacity: 0, duration: 0.2 }, C.temps + 0.4);
      CELLS.forEach((g, c) => tl.to(g, { opacity: 1, duration: 0.15 }, C.transforme + (C.temps - C.transforme + 0.4) * (c / NC)));
      D.blurIn("#ax-t", C.temps - 0.05);
      D.blurIn("#ax-g", C.graves - 0.05);
      D.blurIn("#ax-a", C.aigus - 0.05);
      D.glow("cold", C.carte, 0.45, 0.5);

      // ================= ÉTAPE 2 : les étoiles =================
      step(2, C.e2);
      info(2, C.garde - 0.1, C.e3 - 0.2);
      D.glow("cold", C.e2, 0.15, 0.4); D.glow("amber", C.e2, 0.45, 0.5);
      tl.to(CELLS, { opacity: 0.35, duration: 0.6 }, C.forts - 0.2);
      STARS.forEach((s, j) => tl.fromTo(s, { opacity: 0, scale: 0.2 }, { opacity: 1, scale: 1, duration: 0.3, ease: "back.out(2.4)" }, C.forts - 0.1 + (j % 12) * 0.05));
      tl.to(CELLS, { opacity: 0.06, duration: 0.9 }, C.effaces - 0.3);
      tl.to(STARS, { scale: 1.25, duration: 0.2, yoyo: true, repeat: 1, stagger: 0.01 }, C.constellation);

      // ================= ÉTAPE 3 : les codes =================
      step(3, C.e3);
      const ai = Math.floor(PK.length * 0.3), A0 = PK[ai];
      const zx0 = A0.x + 40, zx1 = Math.min(X0 + W, A0.x + 260), zy0 = A0.y - 170, zy1 = A0.y + 170;
      const ZT = PK.filter((p) => p.x > zx0 && p.x < zx1 && p.y > zy0 && p.y < zy1).slice(0, 4);
      const B0 = ZT[0] || PK[ai + 2];
      document.getElementById("zone").setAttribute("x", zx0); document.getElementById("zone").setAttribute("y", Math.max(Y0, zy0));
      document.getElementById("zone").setAttribute("width", zx1 - zx0); document.getElementById("zone").setAttribute("height", Math.min(Y0 + H, zy1) - Math.max(Y0, zy0));
      tl.to(STARS, { opacity: 0.35, duration: 0.3 }, C.relie - 0.3);
      tl.to([STARS[ai], ...ZT.map((p) => STARS[PK.indexOf(p)])], { opacity: 1, duration: 0.3 }, C.relie - 0.3);
      tl.fromTo(STARS[ai], { scale: 1 }, { scale: 1.6, duration: 0.3, ease: "back.out(2)" }, C.relie - 0.2);
      tl.to("#zone", { opacity: 1, duration: 0.3 }, C.relie);
      { const pair = document.getElementById("pair");
        ZT.forEach((p, j) => { const ln = mk(pair, "line", { x1: A0.x, y1: A0.y, x2: A0.x, y2: A0.y, opacity: j ? 0.5 : 1, "stroke-width": j ? 4 : 7 });
          tl.to(ln, { attr: { x2: p.x, y2: p.y }, duration: 0.35, ease: "power2.out" }, C.deux - 0.1 + j * 0.15); }); }
      // les deux notes et l'écart de temps
      { const dt = document.getElementById("dt"), yb = Math.min(Y0 + H - 20, Math.max(A0.y, B0.y) + 60);
        mk(dt, "path", { d: `M${A0.x} ${yb - 14} v28 M${A0.x} ${yb} H${B0.x} M${B0.x} ${yb - 14} v28` });
        mk(dt, "line", { x1: A0.x, y1: A0.y, x2: A0.x, y2: yb, "stroke-dasharray": "6 8", "stroke-width": 3 });
        mk(dt, "line", { x1: B0.x, y1: B0.y, x2: B0.x, y2: yb, "stroke-dasharray": "6 8", "stroke-width": 3 }); }
      tl.to("#dt", { opacity: 1, duration: 0.3 }, C.ecart - 0.1);
      info(3, C.notes - 0.1, C.e4 - 0.25);
      tl.fromTo(["#zone", "#pair"], { scale: 1 }, { keyframes: [{ scale: 1.04, duration: 0.1 }, { scale: 1, duration: 0.3 }], svgOrigin: `${A0.x} ${A0.y}` }, C.code);
      // des centaines de codes : l'empreinte
      tl.to(["#zone", "#dt"], { opacity: 0, duration: 0.3 }, C.centaines - 0.2);
      tl.to("#pair", { opacity: 0.5, duration: 0.3 }, C.centaines - 0.2);
      { const links = document.getElementById("links"); let n = 0;
        PK.forEach((p, i) => PK.slice(i + 1, i + 4).forEach((q) => { if (q.x - p.x > 260) return;
          const ln = mk(links, "line", { x1: p.x, y1: p.y, x2: p.x, y2: p.y, opacity: 0.45 });
          tl.to(ln, { attr: { x2: q.x, y2: q.y }, duration: 0.25, ease: "power2.out" }, C.centaines + (n++ % 60) * 0.02); })); }
      tl.to(STARS, { opacity: 1, duration: 0.3 }, C.centaines);
      D.glow("amber", C.empreinte - 0.1, 0.7, 0.4);
      tl.to("#stage", { scale: 1.03, transformOrigin: "540px 790px", duration: 0.2, yoyo: true, repeat: 1 }, C.empreinte);

      // ================= ÉTAPE 4 : la recherche =================
      step(4, C.e4);
      D.glow("amber", C.e4, 0.25, 0.4); D.glow("red", C.e4, 0.4, 0.4);
      tl.to(["#links", "#pair", "#cells", "#mapframe", "#ax-t", "#ax-a", "#ax-g"], { opacity: 0, duration: 0.3 }, C.e4 - 0.15);
      // les étoiles se rangent en une bande : ton extrait
      const SY0 = 530, SH = 80, sx = (p) => X0 + 20 + ((p.x - X0) / W) * (W - 40), sy = (p) => SY0 + SH - ((Y0 + H - p.y) / H) * SH;
      STARS.forEach((s, j) => { const p = PK[j];
        tl.to(s, { x: sx(p) - p.x, y: sy(p) - p.y, scale: 0.55, duration: 0.5, ease: "power3.inOut" }, C.e4 + (j % 10) * 0.012); });
      D.blurIn("#ex-lab", C.e4 + 0.3);
      // les chansons de la base
      const ROW = { a: 640, b: 790, c: 940 }, RY = (k) => ROW[k] + 52, RHh = 56;
      const sd = document.getElementById("songdots");
      const dots = (k, pts) => pts.map(([x, f]) => mk(sd, "circle", { cx: x.toFixed(1), cy: (RY(k) + RHh - f * RHh).toFixed(1), r: 6, fill: "#ece6d6", opacity: 0, class: "sd-" + k }));
      const rand = () => Array.from({ length: PK.length }, () => [X0 + 20 + rnd() * (W - 40), rnd()]);
      const norm = (p) => [sx(p), (Y0 + H - p.y) / H];
      dots("a", rand()); dots("b", rand());
      dots("c", [...PK.map(norm), ...Array.from({ length: 10 }, () => [X0 + 20 + rnd() * (W - 40), rnd()])]);
      ["#so-a", "#so-b", "#so-c"].forEach((s, j) => tl.fromTo(s, { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.base - 0.1 + j * 0.08));
      ["a", "b", "c"].forEach((k, j) => tl.to(".sd-" + k, { opacity: 0.8, duration: 0.3 }, C.base + j * 0.08));
      // le fantôme de l'extrait passe sur chaque chanson
      const gh = document.getElementById("ghost");
      const GH = PK.map((p) => mk(gh, "circle", { cx: sx(p).toFixed(1), cy: (RY("a") + RHh - ((Y0 + H - p.y) / H) * RHh).toFixed(1), r: 10, fill: "none", stroke: "#ffb21f", "stroke-width": 4, opacity: 0 }));
      const tA = C.bonne - 0.3, tB = tA + 0.6, tC = C.ordre - 0.5;
      tl.to(GH, { opacity: 1, duration: 0.15 }, tA);
      tl.to("#ghost", { y: 0, duration: 0.01 }, tA);
      tl.to("#so-a .res", { opacity: 1, duration: 0.15 }, tA + 0.3);
      tl.to("#ghost", { y: ROW.b - ROW.a, duration: 0.25, ease: "power2.inOut" }, tB);
      tl.to("#so-b .res", { opacity: 1, duration: 0.15 }, tB + 0.3);
      tl.to("#ghost", { y: ROW.c - ROW.a, duration: 0.25, ease: "power2.inOut" }, tC);
      tl.to(["#so-a", "#so-b", ".sd-a", ".sd-b"], { opacity: 0.3, duration: 0.3 }, C.ordre);
      tl.to("#so-c", { borderColor: "#ffb21f", duration: 0.2 }, C.rythme - 0.1);
      tl.to(GH, { attr: { fill: "#ffb21f" }, duration: 0.15, stagger: 0.008 }, C.ordre);
      tl.to("#so-c .res", { opacity: 1, duration: 0.15 }, C.rythme);
      D.popIn("#in4", C.ordre - 0.2, 0.5);
      D.flash(C.rythme, 0.14, "#ffb21f");
      D.shake(C.rythme + 0.02, 8);

      // ================= BONUS : 1 ou 2 % suffisent =================
      D.blurOut(["#in4", "#st4"], C.fou - 0.3, 0.15);
      tl.to(["#so-a", "#so-b", "#so-c", "#songdots", "#ghost", "#ex-lab", "#stars"], { opacity: 0, duration: 0.3 }, C.fou - 0.3);
      D.glow("red", C.fou, 0, 0.4); D.glow("cold", C.fou, 0.4, 0.4);
      const cg = document.getElementById("codes"), CODES = [];
      for (let k = 0; k < 100; k++) { const c = k % 10, r = Math.floor(k / 10);
        CODES.push(mk(cg, "rect", { x: 290 + c * 52, y: 690 + r * 38, width: 40, height: 26, rx: 7, fill: "#ece6d6", opacity: 0 })); }
      CODES.forEach((c, k) => tl.to(c, { opacity: 0.9, duration: 0.12 }, C.fou + (k % 25) * 0.012 + Math.floor(k / 25) * 0.05));
      D.blurIn("#pct", C.fou + 0.1);
      const keep = [23, 76];
      D.count("pct-n", 100, 2, C.reste - 0.1, 1.2, 0);
      CODES.forEach((c, k) => { if (!keep.includes(k)) tl.to(c, { opacity: 0.1, attr: { fill: "#4cc4ff" }, duration: 0.2 }, C.reste + rnd() * 1.0); });
      keep.forEach((k) => tl.to(CODES[k], { attr: { fill: "#ffb21f" }, duration: 0.2 }, C.un));
      info(5, C.un - 0.05, null);
      tl.fromTo(keep.map((k) => CODES[k]), { scale: 1, transformOrigin: "50% 50%" }, { keyframes: [{ scale: 1.7, duration: 0.12 }, { scale: 1.3, duration: 0.3, ease: "expo.out" }] }, C.suffit);
      D.glow("cold", C.suffit, 0, 0.4); D.glow("amber", C.suffit, 0.7, 0.3);

      // ================= LA CHUTE : en concert =================
      tl.to(["#codes", "#pct", "#in5"], { opacity: 0, filter: "blur(10px)", duration: 0.2 }, C.concert - 0.3);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.1, ease: "power2.out" }, C.concert - 0.2);
      D.glow("amber", C.concert, 0.2, 0.4); D.glow("cold", C.concert, 0.5, 0.4);
      { const lv = document.getElementById("live"); const N = 16;
        for (let j = 0; j < N; j++) { const x = 160 + j * 50, f = 0.5 + 0.4 * Math.sin(j * 1.3);
          const a = mk(lv, "circle", { cx: x, cy: 610 + 160 - f * 140, r: 11, fill: "#ece6d6", opacity: 0 });
          const xl = 160 + j * 50 * 1.07 + 18 * Math.sin(j * 2.1), fl = f + 0.18 * Math.cos(j * 1.7);
          const b = mk(lv, "circle", { cx: xl.toFixed(1), cy: (840 + 160 - fl * 140).toFixed(1), r: 11, fill: "#ffb21f", opacity: 0 });
          tl.to(a, { opacity: 1, duration: 0.15 }, C.concert + 0.1 + j * 0.02);
          tl.to(b, { opacity: 1, duration: 0.15 }, C.muet - 0.2 + j * 0.02); } }
      D.blurIn("#vl-s", C.concert + 0.1);
      D.blurIn("#vl-l", C.muet - 0.2);
      D.stamp("#tw-stamp span", C.live, -5);
      D.shake(C.live + 0.02, 12);
      D.glow("red", C.live, 0.6, 0.3);
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
