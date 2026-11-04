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
      #hero-w { position: absolute; inset: 0; overflow: hidden; }
      #hero { position: absolute; left: 0; top: 0; width: 1080px; height: 1920px; object-fit: cover; }
      #hero-shade { position: absolute; inset: 0; background: linear-gradient(180deg, rgba(11,11,14,.78) 0%, rgba(11,11,14,.25) 34%, rgba(11,11,14,0) 50%, rgba(11,11,14,.35) 100%); }
      #h-t1 { top: 300px; font-size: 100px; }
      #h-t2 { top: 300px; font-size: 104px; }
      #h-t2 .wsp { opacity: 0; }
      #h-stamp { top: 640px; }
      #hk { position: absolute; inset: 0; }

      /* ---------- schéma ---------- */
      #stage { position: absolute; left: 0; top: 0; width: 1080px; height: 1920px; }
      #stage svg { position: absolute; left: 0; top: 0; }
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: relative; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 290px; height: 80px; }
      #infos { top: 384px; height: 80px; }
      #topshade { position: absolute; left: 0; right: 0; top: 0; height: 480px; opacity: 0;
        background: linear-gradient(180deg, rgba(11,11,14,1) 0%, rgba(11,11,14,.94) 62%, rgba(11,11,14,0) 100%); }
      #capshade { position: absolute; left: 0; right: 0; top: 1120px; height: 800px; opacity: 0;
        background: linear-gradient(180deg, rgba(11,11,14,0) 0%, rgba(11,11,14,.92) 9%, rgba(11,11,14,.97) 100%); }

      /* carte « le secret » */
      #card { position: absolute; left: 130px; top: 430px; width: 820px; height: 640px; border-radius: 44px;
        background: rgba(22,22,27,.96); border: 3px solid var(--line); opacity: 0; overflow: hidden;
        box-shadow: 0 40px 120px rgba(0,0,0,.55); }
      #card .k { position: absolute; top: 54px; left: 0; right: 0; text-align: center; font-size: 34px; font-weight: 800;
        letter-spacing: .16em; color: var(--amber); }
      #card .g { position: absolute; top: 118px; left: 0; right: 0; text-align: center; font-size: 56px; font-weight: 800; }
      #card .w { position: absolute; top: 186px; left: 0; right: 0; text-align: center; font-size: 118px; font-weight: 900;
        letter-spacing: -.04em; color: var(--cold); text-transform: uppercase; }
      #card .t { position: absolute; top: 352px; left: 250px; font-size: 170px; font-weight: 900; letter-spacing: -.05em; line-height: 1; white-space: nowrap; }
      #card .t small { font-size: 90px; letter-spacing: -.03em; }
      #card .n { position: absolute; top: 548px; left: 250px; font-size: 30px; font-weight: 700; color: var(--muted); }
      #card svg { position: absolute; left: 80px; top: 330px; }
      #card .g, #card .w, #card .t, #card .n, #card .k { opacity: 0; }

      /* chute */
      #tw-title { top: 300px; font-size: 80px; }
      #tw-title .wsp { opacity: 0; }
      #tw-stamp { top: 330px; }
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
        <!-- 1. Accroche : la vraie image, la phrase qui contredit -->
        <div id="s-hook" class="clip" data-start="0" data-duration="%%HOOK_D%%" data-track-index="1" data-track-kind="graphics">
          <div id="hero-w"><img id="hero" src="assets/hero.jpg" alt="" /><div id="hero-shade"></div></div>
          <svg id="hk" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true"></svg>
          <div id="h-t1" class="hl">Ton frigo ne<br />fabrique <span class="c">pas</span><br /><span class="c">de froid.</span></div>
          <div id="h-t2" class="hl"><span class="wsp">Il</span> <span class="wsp">déplace</span><br /><span class="wsp">la</span> <span class="wsp r">chaleur&nbsp;!</span></div>
          <div id="h-stamp" class="stamp"><span>Jamais.</span></div>
        </div>

        <!-- 2. Le schéma : vue en coupe et circuit du gaz -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="stage">
            <svg width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <defs>
                <filter id="soft" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="28" /></filter>
                <filter id="soft2" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="9" /></filter>
                <linearGradient id="mercury" x1="0" y1="1" x2="0" y2="0">
                  <stop offset="0" stop-color="#ff5236" /><stop offset="1" stop-color="#ffb21f" />
                </linearGradient>
              </defs>
              <!-- halos -->
              <ellipse id="frost" cx="535" cy="620" rx="150" ry="150" fill="#4cc4ff" opacity="0" filter="url(#soft)" />
              <ellipse id="hotback" cx="747" cy="760" rx="120" ry="320" fill="#ff7a2f" opacity="0" filter="url(#soft)" />
              <ellipse id="compglow" cx="720" cy="1088" rx="120" ry="70" fill="#ff5236" opacity="0" filter="url(#soft)" />
              <!-- frigo -->
              <g id="fridge">
                <rect id="body" x="200" y="470" width="440" height="660" rx="40" fill="#121217" stroke="#ece6d6" stroke-width="6" />
                <rect id="tint" x="232" y="502" width="376" height="596" rx="22" fill="#4cc4ff" opacity="0" />
                <line x1="232" y1="800" x2="450" y2="800" stroke="#3a3a44" stroke-width="6" stroke-linecap="round" />
                <line x1="232" y1="960" x2="450" y2="960" stroke="#3a3a44" stroke-width="6" stroke-linecap="round" />
                <g id="food">
                  <rect x="252" y="872" width="34" height="86" rx="12" fill="#5d5b64" />
                  <rect x="260" y="858" width="18" height="18" rx="4" fill="#5d5b64" />
                  <circle cx="338" cy="934" r="25" fill="#8e8c95" />
                  <polygon points="250,796 340,796 340,752" fill="#8e8c95" />
                  <rect x="252" y="1040" width="140" height="56" rx="14" fill="#5d5b64" />
                </g>
                <rect id="door" x="186" y="478" width="26" height="644" rx="12" fill="#ece6d6" />
              </g>
              <!-- tuyaux (fond) -->
              <g id="pipes" fill="none" stroke="#34343d" stroke-width="12" stroke-linecap="round" stroke-linejoin="round">
                <polyline id="p-evap" /><polyline id="p-suc" /><polyline id="p-comp" /><polyline id="p-dis" />
                <polyline id="p-cond" stroke="#4a3a33" /><polyline id="p-cap" stroke-width="7" />
              </g>
              <!-- tuyaux (surbrillance par étape) -->
              <g fill="none" stroke-width="15" stroke-linecap="round" stroke-linejoin="round">
                <polyline id="h-evap" stroke="#4cc4ff" opacity="0" /><polyline id="h-suc" stroke="#ff5236" opacity="0" />
                <polyline id="h-dis" stroke="#ff5236" opacity="0" /><polyline id="h-cond" stroke="#ff7a2f" opacity="0" />
                <polyline id="h-cap" stroke="#4cc4ff" stroke-width="9" opacity="0" />
              </g>
              <!-- ondes de chaleur -->
              <g id="shimmer" fill="none" stroke="#ff7a2f" stroke-width="7" stroke-linecap="round" opacity="0">
                <path d="M700 420 q 14 -24 0 -48 q -14 -24 0 -48" /><path d="M752 420 q 14 -24 0 -48 q -14 -24 0 -48" /><path d="M804 420 q 14 -24 0 -48 q -14 -24 0 -48" />
              </g>
              <g id="arcs" fill="none" stroke="#ff7a2f" stroke-linecap="round">
                <path class="arc" d="M860 600 q 60 160 0 320" stroke-width="12" opacity="0" />
                <path class="arc" d="M860 600 q 60 160 0 320" stroke-width="12" opacity="0" />
                <path class="arc" d="M860 600 q 60 160 0 320" stroke-width="12" opacity="0" />
              </g>
              <!-- chaleur qui voyage -->
              <g id="heat"></g>
              <!-- le gaz -->
              <g id="parts"></g>
              <!-- compresseur (au-dessus du gaz, qui passe dedans) -->
              <g id="comp">
                <rect x="650" y="1050" width="140" height="78" rx="20" fill="#1d1d23" stroke="#ece6d6" stroke-width="5" />
                <rect x="672" y="1068" width="96" height="10" rx="5" fill="#3a3a44" />
                <rect x="672" y="1096" width="96" height="10" rx="5" fill="#3a3a44" />
              </g>
              <!-- air froid qui sort -->
              <g id="puff"></g>
              <!-- thermomètre de la cuisine -->
              <g id="thermo" opacity="0">
                <rect x="926" y="560" width="48" height="400" rx="24" fill="#16161b" stroke="#ece6d6" stroke-width="5" />
                <circle cx="950" cy="985" r="44" fill="#16161b" stroke="#ece6d6" stroke-width="5" />
                <rect id="merc" x="938" y="640" width="24" height="330" rx="12" fill="url(#mercury)" />
                <circle cx="950" cy="985" r="31" fill="#ff5236" />
              </g>
              <!-- numéros des étapes, posés sur les pièces -->
              <g id="badges" font-family="Inter Display" font-weight="900" font-size="30" text-anchor="middle">
                <g id="b1" opacity="0"><circle cx="410" cy="560" r="27" fill="#4cc4ff" /><text x="410" y="571" fill="#0b0b0e">1</text></g>
                <g id="b2" opacity="0"><circle cx="720" cy="1170" r="27" fill="#ff5236" /><text x="720" y="1181" fill="#0b0b0e">2</text></g>
                <g id="b3" opacity="0"><circle cx="905" cy="760" r="27" fill="#ffb21f" /><text x="905" y="771" fill="#0b0b0e">3</text></g>
                <g id="b4" opacity="0"><circle cx="686" cy="392" r="27" fill="#4cc4ff" /><text x="686" y="403" fill="#0b0b0e">4</text></g>
              </g>
            </svg>
          </div>

          <div id="capshade"></div>
          <div id="topshade"></div>

          <div id="steps" class="row">
            <div id="st1" class="chip cold" style="position:absolute"><b>1</b>ÉVAPORATION</div>
            <div id="st2" class="chip hot" style="position:absolute"><b>2</b>COMPRESSION</div>
            <div id="st3" class="chip amb" style="position:absolute"><b>3</b>CONDENSATION</div>
            <div id="st4" class="chip cold" style="position:absolute"><b>4</b>DÉTENTE</div>
          </div>
          <div id="infos" class="row">
            <div id="in0" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Tiède au toucher</div>
            <div id="in1" class="chip" style="position:absolute"><i style="background:var(--cold)"></i>Comme la sueur qui s'évapore</div>
            <div id="in2" class="chip" style="position:absolute"><i style="background:var(--red)"></i>Comprimé = plus chaud</div>
            <div id="in3" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Gaz → liquide</div>
            <div id="in4" class="chip" style="position:absolute"><i style="background:var(--cold)"></i>Pression ↓ = glacé</div>
            <div id="in5" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>En boucle, jour et nuit</div>
          </div>

          <div id="card">
            <div class="k">LE SECRET</div>
            <div class="g">Un gaz :</div>
            <div class="w">l'isobutane</div>
            <svg width="130" height="270" viewBox="0 0 130 270" aria-hidden="true">
              <rect x="41" y="10" width="48" height="190" rx="24" fill="#0b0b0e" stroke="#ece6d6" stroke-width="5" />
              <circle cx="65" cy="222" r="40" fill="#0b0b0e" stroke="#ece6d6" stroke-width="5" />
              <rect id="cmerc" x="53" y="40" width="24" height="170" rx="12" fill="#4cc4ff" />
              <circle cx="65" cy="222" r="27" fill="#4cc4ff" />
            </svg>
            <div class="t"><span id="t-num">20</span><small>&nbsp;°C</small></div>
            <div class="n">Il bout à −11,7&nbsp;°C</div>
            <div id="bubbles"></div>
          </div>

          <div id="tw-title" class="hl"><span class="wsp">Et</span> <span class="wsp">si</span> <span class="wsp">tu</span> <span class="wsp c">ouvres</span><br /><span class="wsp">la</span> <span class="wsp c">porte&nbsp;?</span></div>
          <div id="tw-stamp" class="stamp"><span>Ça la réchauffe&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin (DA) -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 1 · Le frigo</div>
          <div id="c-src">Sources : Université de l'Illinois (Physics Van), Institut international du froid</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#1</span>
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
      gsap.set(["#b1", "#b2", "#b3", "#b4"], { transformOrigin: "50% 50%" });
      const tl = gsap.timeline({ paused: true });
      const D = DA(tl);

      // ================= géométrie du circuit (calculée, sans mesure du DOM) =================
      const SEG = {
        evap: [[550,470],[550,520],[470,520],[470,560],[600,560],[600,600],[470,600],[470,640],[600,640],[600,680],[470,680],[470,720],[600,720]],
        suc:  [[600,720],[626,720],[626,1088],[650,1088]],
        comp: [[650,1088],[790,1088]],
        dis:  [[790,1088],[822,1088],[822,1030]],
        cond: (() => { const p = []; for (let k = 0; k < 10; k++) { const y = 1030 - 60 * k; const [a, b] = k % 2 ? [672, 822] : [822, 672]; p.push([a, y], [b, y]); } return p; })(),
        cap:  (() => { const p = [[822,490],[822,432]]; let x = 822, s = 1; while (x > 567) { x -= 17; p.push([x, 432 + 10 * s]); s = -s; } p.push([550,432],[550,470]); return p; })(),
      };
      const ORDER = ["evap", "suc", "comp", "dis", "cond", "cap"];
      const ptsStr = (p) => p.map((q) => q.join(",")).join(" ");
      const plen = (p) => p.slice(1).reduce((s, q, i) => s + Math.hypot(q[0] - p[i][0], q[1] - p[i][1]), 0);
      const LEN = {}; ORDER.forEach((k) => (LEN[k] = plen(SEG[k])));
      ["evap", "suc", "comp", "dis", "cond", "cap"].forEach((k) => {
        const el = document.getElementById("p-" + k); el.setAttribute("points", ptsStr(SEG[k]));
        el.style.strokeDasharray = LEN[k] + 2; el.style.strokeDashoffset = LEN[k] + 2;
      });
      ["evap", "suc", "dis", "cond", "cap"].forEach((k) => document.getElementById("h-" + k).setAttribute("points", ptsStr(SEG[k])));
      const LOOP = ORDER.flatMap((k, i) => (i ? SEG[k].slice(1) : SEG[k]));
      const TOTAL = ORDER.reduce((s, k) => s + LEN[k], 0);
      const cum = []; { let s = 0; LOOP.forEach((q, i) => { if (i) s += Math.hypot(q[0] - LOOP[i - 1][0], q[1] - LOOP[i - 1][1]); cum.push(s); }); }
      const at = (d) => { d = ((d % TOTAL) + TOTAL) % TOTAL; let i = 1; while (i < cum.length - 1 && cum[i] < d) i++; const f = (d - cum[i - 1]) / Math.max(1e-6, cum[i] - cum[i - 1]); return [LOOP[i - 1][0] + (LOOP[i][0] - LOOP[i - 1][0]) * f, LOOP[i - 1][1] + (LOOP[i][1] - LOOP[i - 1][1]) * f]; };
      // couleur du gaz selon l'endroit du circuit : froid → tiède → brûlant → tiède → glacé
      const hex = (h) => [1, 3, 5].map((i) => parseInt(h.slice(i, i + 2), 16));
      const B = {}; { let s = 0; ORDER.forEach((k) => { B[k] = [s, s + LEN[k]]; s += LEN[k]; }); }
      const STOPS = [[0, "#4cc4ff"], [B.evap[1], "#9fe0ff"], [B.suc[1], "#c2d6df"], [B.comp[0] + LEN.comp * 0.55, "#ff5236"],
        [B.cond[0] + LEN.cond * 0.15, "#ff5236"], [B.cond[0] + LEN.cond * 0.6, "#ffb21f"], [B.cond[1], "#ece6d6"], [B.cap[0] + LEN.cap * 0.8, "#d8e6ec"], [TOTAL, "#4cc4ff"]].map(([d, c]) => [d, hex(c)]);
      const colorAt = (d) => { d = ((d % TOTAL) + TOTAL) % TOTAL; let i = 1; while (i < STOPS.length - 1 && STOPS[i][0] < d) i++;
        const [d0, c0] = STOPS[i - 1], [d1, c1] = STOPS[i], f = (d - d0) / Math.max(1e-6, d1 - d0);
        return `rgb(${c0.map((v, j) => Math.round(v + (c1[j] - v) * f)).join(",")})`; };

      // ================= le gaz : 36 particules, vitesse pilotée par le temps =================
      const N = 36, parts = document.getElementById("parts");
      const P = Array.from({ length: N }, () => mk(parts, "circle", { r: 9, cx: 550, cy: 470, fill: "#4cc4ff" }));
      const LOOP_IN = C.e1 - 0.35;
      const SPEED = [[LOOP_IN, 0], [LOOP_IN + 0.8, 230], [C.boucle - 0.3, 230], [C.boucle + 0.3, 600], [C.alors, 600], [C.alors + 0.6, 300], [C.end, 300]];
      const PH = []; { let ph = 0; for (let t = LOOP_IN; t <= C.end + 0.05; t += 1 / 60) { PH.push(ph); let i = 1; while (i < SPEED.length - 1 && SPEED[i][0] < t) i++;
        const [t0, v0] = SPEED[i - 1], [t1, v1] = SPEED[i], v = v0 + (v1 - v0) * Math.min(1, Math.max(0, (t - t0) / Math.max(1e-6, t1 - t0))); ph += v / 60; } }
      const drawParts = (t) => { const k = Math.max(0, Math.min(PH.length - 1, (t - LOOP_IN) * 60)); const i = Math.floor(k), f = k - i;
        const ph = PH[i] + ((PH[Math.min(i + 1, PH.length - 1)] - PH[i]) * f);
        P.forEach((c, j) => { const d = ph + (j / N) * TOTAL; const [x, y] = at(d); c.setAttribute("cx", x.toFixed(1)); c.setAttribute("cy", y.toFixed(1)); c.setAttribute("fill", colorAt(d)); }); };
      drawParts(LOOP_IN);
      { const o = { p: 0 }, dur = C.end - LOOP_IN;
        tl.to(o, { p: 1, duration: dur, ease: "none", onUpdate() { drawParts(LOOP_IN + this.progress() * dur); } }, LOOP_IN); }
      tl.fromTo(P, { opacity: 0 }, { opacity: 1, duration: 0.3, stagger: 0.015 }, C.e1 + 0.1);

      // ================= décor continu =================
      D.drift(C.end);

      // ================= 1. ACCROCHE =================
      D.glow("cold", 0, 0.5, 0.01);
      tl.fromTo("#hero", { scale: 1.07 }, { scale: 1, duration: C.pose, ease: "power1.out" }, 0);
      D.stamp("#h-stamp span", C.jamais, -5);
      D.shake(C.jamais + 0.02, 10);
      // la chaleur part de l'intérieur vers l'arrière
      { const hk = document.getElementById("hk"); const dots = Array.from({ length: 12 }, () => mk(hk, "circle", { r: 15, cx: 440, cy: 1250, fill: "#4cc4ff", opacity: 0 }));
        const bz = (p) => { const a = [440, 1250], c = [900, 1330], b = [810, 760], u = 1 - p; return [u * u * a[0] + 2 * u * p * c[0] + p * p * b[0], u * u * a[1] + 2 * u * p * c[1] + p * p * b[1]]; };
        const t0 = C.deplace - 0.1, dur = C.pose - t0 - 0.1, o = { p: 0 };
        tl.to(o, { p: 1, duration: dur, ease: "none", onUpdate() { const pr = this.progress();
          dots.forEach((d, j) => { const p = Math.min(1, Math.max(0, pr * 1.6 - j * 0.05)); const [x, y] = bz(p);
            d.setAttribute("cx", x.toFixed(1)); d.setAttribute("cy", y.toFixed(1)); d.setAttribute("opacity", p > 0 && p < 1 ? Math.min(1, Math.sin(p * Math.PI) * 1.6).toFixed(2) : 0);
            const c0 = hex("#4cc4ff"), c1 = hex("#ff7a2f"); d.setAttribute("fill", `rgb(${c0.map((v, k) => Math.round(v + (c1[k] - v) * p)).join(",")})`); }); } }, t0); }
      D.blurOut(["#h-t1", "#h-stamp span"], C.il - 0.12, 0.14);
      tl.fromTo("#h-t2 .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.12, ease: "power2.out" }, C.il);
      D.glow("red", C.chaleur - 0.1, 0.5, 0.4);
      // l'image devient le schéma
      const T1 = C.pose - 0.14;
      tl.to("#hero-w", { scale: 1.16, opacity: 0, duration: 0.32, ease: "power3.in" }, T1 - 0.1);
      D.blurOut("#h-t2", T1 - 0.1, 0.18);
      D.glow("cold", T1, 0, 0.4); D.glow("red", T1, 0, 0.4); D.glow("cream", T1, 0.45, 0.4);
      tl.fromTo("#stage", { opacity: 0, scale: 0.94, transformOrigin: "540px 800px", filter: "blur(12px)" },
        { opacity: 1, scale: 1, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, T1 + 0.05);
      tl.to("#capshade", { opacity: 1, duration: 0.3 }, T1 + 0.1);

      // ================= 2. L'ARRIÈRE EST TIÈDE =================
      tl.to("#p-cond", { strokeDashoffset: 0, duration: 0.7, ease: "power2.out" }, C.arriere - 0.1);
      tl.to("#h-cond", { opacity: 0.85, duration: 0.4 }, C.arriere + 0.2);
      tl.to("#hotback", { opacity: 0.5, duration: 0.5 }, C.arriere + 0.2);
      tl.fromTo("#shimmer", { opacity: 0, y: 30 }, { opacity: 0.9, y: 0, duration: 0.4 }, C.cotes);
      tl.to("#shimmer", { y: -40, duration: 1.0, ease: "none", repeat: 2, yoyo: true }, C.cotes + 0.4);
      D.popIn("#in0", C.tiede - 0.05, 0.5);
      D.glow("amber", C.tiede, 0.45, 0.4);
      // la chaleur de la nourriture traverse le mur et part derrière
      { const heat = document.getElementById("heat");
        [[269, 900], [338, 934], [300, 780], [320, 1060], [269, 900], [338, 934]].forEach(([x, y], j) => {
          const c = mk(heat, "circle", { r: 12, cx: x, cy: y, fill: "#ff7a2f", opacity: 0 });
          tl.fromTo(c, { attr: { cx: x, cy: y }, opacity: 0 }, { keyframes: [ { opacity: 1, duration: 0.12 },
            { attr: { cx: 760, cy: 640 + j * 40 }, duration: 0.85, ease: "power2.inOut" }, { opacity: 0, duration: 0.15 } ] }, C.part - 0.1 + j * 0.12); }); }
      D.blurOut("#in0", C.secret - 0.25, 0.15);
      tl.to("#shimmer", { opacity: 0, duration: 0.3 }, C.secret - 0.25);

      // ================= 3. LE SECRET : L'ISOBUTANE =================
      D.glow("amber", C.secret - 0.2, 0, 0.3);
      D.glow("cold", C.secret - 0.2, 0.5, 0.4);
      tl.to("#stage", { opacity: 0.18, duration: 0.3 }, C.secret - 0.12);
      tl.to("#stage", { opacity: 1, duration: 0.35 }, C.e1 - 0.4);
      tl.fromTo("#card", { opacity: 0, scale: 0.9, y: 40 }, { opacity: 1, scale: 1, y: 0, duration: 0.35, ease: "expo.out" }, C.secret - 0.12);
      D.blurIn("#card .k", C.secret);
      D.blurIn("#card .g", C.gaz - 0.04);
      D.blurIn("#card .w", C.iso - 0.04, 0.22);
      tl.fromTo("#card .w", { scale: 1.12 }, { scale: 1, duration: 0.5, ease: "expo.out" }, C.iso - 0.04);
      D.blurIn(["#card .t", "#card svg"], C.bout - 0.2, 0.2);
      D.count("t-num", 20, -12, C.moins - 0.35, 1.0, 0);
      tl.fromTo("#cmerc", { scaleY: 1, transformOrigin: "50% 100%" }, { scaleY: 0.18, duration: 1.0, ease: "power2.out" }, C.moins - 0.35);
      D.blurIn("#card .n", C.bout - 0.15);
      { const bb = document.getElementById("bubbles");
        for (let j = 0; j < 9; j++) { const d = document.createElement("div");
          d.style.cssText = `position:absolute;left:${300 + j * 52}px;top:600px;width:${14 + (j % 3) * 6}px;height:${14 + (j % 3) * 6}px;border-radius:50%;border:3px solid #4cc4ff;opacity:0`;
          bb.appendChild(d);
          tl.fromTo(d, { y: 0, opacity: 0 }, { keyframes: [{ opacity: 0.9, duration: 0.1 }, { y: -220 - (j % 4) * 40, duration: 1.1, ease: "power1.out" }, { opacity: 0, duration: 0.15 }] }, C.bout - 0.05 + (j % 5) * 0.09); } }
      // la carte se range dans l'évaporateur
      tl.to("#card", { scale: 0.12, x: -6, y: -170, opacity: 0, filter: "blur(10px)", duration: 0.42, ease: "power3.in" }, C.e1 - 0.42);
      // le circuit se dessine
      ["evap", "suc", "comp", "dis", "cap"].forEach((k, i) => tl.to("#p-" + k, { strokeDashoffset: 0, duration: 0.45, ease: "power2.out" }, C.e1 - 0.3 + i * 0.05));
      tl.to(["#h-cond", "#hotback"], { opacity: 0, duration: 0.3 }, C.e1 - 0.3);

      // ================= zooms de caméra sur les pièces =================
      const zoom = (s, fx, fy, t, d = 0.8) => tl.to("#stage", { scale: s, x: 540 - s * fx, y: 760 - s * fy, transformOrigin: "0px 0px", duration: d, ease: "power2.inOut" }, t);
      tl.set("#stage", { transformOrigin: "0px 0px", scale: 1, x: 0, y: 0 }, T1 + 0.52);
      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.1, 0.12); D.popIn("#st" + n, t, 0.6); D.popIn("#b" + n, t + 0.1, 0.4); };

      // ÉTAPE 1 — évaporation
      step(1, C.e1);
      tl.to("#topshade", { opacity: 1, duration: 0.4 }, C.e1 - 0.05);
      tl.to("#topshade", { opacity: 0, duration: 0.4 }, C.et_boucle);
      zoom(1.35, 500, 700, C.e1 - 0.05);
      tl.to("#h-evap", { opacity: 1, duration: 0.4 }, C.sevapore - 0.1);
      tl.to("#frost", { opacity: 0.55, duration: 0.6 }, C.sevapore);
      tl.to("#tint", { opacity: 0.1, duration: 0.8 }, C.sevapore + 0.2);
      D.glow("cold", C.sevapore, 0.7, 0.5); D.glow("cream", C.sevapore, 0, 0.4);
      { const heat = document.getElementById("heat");
        [[269, 900], [338, 934], [300, 780], [320, 1060], [338, 934]].forEach(([x, y], j) => {
          const c = mk(heat, "circle", { r: 11, cx: x, cy: y, fill: "#ff7a2f", opacity: 0 });
          tl.fromTo(c, { attr: { cx: x, cy: y }, opacity: 0 }, { keyframes: [ { opacity: 1, duration: 0.1 },
            { attr: { cx: 520 + j * 18, cy: 560 + j * 30 }, duration: 0.7, ease: "power2.in" }, { opacity: 0, duration: 0.1 } ] }, C.aspire - 0.1 + j * 0.13); }); }
      D.popIn("#in1", C.sueur - 0.4, 0.5);
      D.blurOut("#in1", C.e2 + 0.1, 0.15);

      // ÉTAPE 2 — compression
      tl.to(["#h-evap", "#frost"], { opacity: 0.25, duration: 0.4 }, C.e2 - 0.1);
      step(2, C.e2);
      zoom(1.45, 730, 990, C.e2 - 0.05);
      D.glow("cold", C.e2, 0, 0.4); D.glow("red", C.e2, 0.55, 0.5);
      tl.to(["#h-suc", "#h-dis"], { opacity: 0.9, duration: 0.4 }, C.compresseur - 0.1);
      tl.to("#comp", { svgOrigin: "720 1128", keyframes: [ { scaleY: 0.84, duration: 0.12 }, { scaleY: 1, duration: 0.2 }, { scaleY: 0.84, duration: 0.12 }, { scaleY: 1, duration: 0.2 },
        { scaleY: 0.84, duration: 0.12 }, { scaleY: 1, duration: 0.3, ease: "back.out(2)" } ] }, C.lecrase - 0.05);
      tl.to("#compglow", { opacity: 0.8, duration: 0.5 }, C.lecrase);
      D.popIn("#in2", C.comprime - 0.1, 0.5);
      D.blurOut("#in2", C.e3 - 0.25, 0.15);

      // ÉTAPE 3 — condensation : la chaleur part dans la cuisine
      tl.to(["#h-suc", "#compglow"], { opacity: 0.2, duration: 0.4 }, C.e3 - 0.1);
      tl.to("#h-dis", { opacity: 0.3, duration: 0.4 }, C.e3 - 0.1);
      step(3, C.e3);
      zoom(1.3, 770, 760, C.e3 - 0.05);
      D.glow("red", C.e3, 0.25, 0.4); D.glow("amber", C.e3, 0.6, 0.5);
      tl.to("#h-cond", { opacity: 0.95, duration: 0.4 }, C.lexterieur - 0.1);
      tl.to("#hotback", { opacity: 0.7, duration: 0.5 }, C.lexterieur);
      gsap.utils.toArray("#arcs .arc").forEach((a, j) => {
        tl.fromTo(a, { x: 0, opacity: 0 }, { keyframes: [{ opacity: 0.9, duration: 0.15 }, { x: 130, duration: 0.9, ease: "power1.out" }, { opacity: 0, duration: 0.2 }], repeat: 1, repeatDelay: 0.2 }, C.relache + j * 0.28); });
      D.popIn("#in3", C.liquide - 0.25, 0.5);
      D.blurOut("#in3", C.e4 - 0.25, 0.15);

      // ÉTAPE 4 — détente dans le tube minuscule
      tl.to(["#h-cond", "#hotback", "#h-dis", "#h-suc"], { opacity: 0, duration: 0.4 }, C.e4 - 0.1);
      step(4, C.e4);
      tl.to("#b3", { opacity: 0, duration: 0.2 }, C.e4);
      tl.to("#b3", { opacity: 1, duration: 0.3 }, C.et_boucle + 0.2);
      zoom(1.6, 690, 470, C.e4 - 0.05);
      D.glow("amber", C.e4, 0, 0.4); D.glow("cold", C.e4, 0.55, 0.5);
      tl.to("#h-cap", { opacity: 1, duration: 0.3 }, C.tube - 0.05);
      tl.fromTo("#h-cap", { strokeWidth: 9 }, { keyframes: [{ strokeWidth: 15, duration: 0.15 }, { strokeWidth: 9, duration: 0.3 }] }, C.tube);
      D.popIn("#in4", C.pression - 0.1, 0.5);
      tl.to(["#h-evap", "#frost"], { opacity: 1, duration: 0.25 }, C.glace - 0.05);
      D.flash(C.glace, 0.14, "#4cc4ff");

      // EN BOUCLE — on revoit tout
      D.blurOut(["#in4", "#st4"], C.boucle - 0.35, 0.15);
      zoom(1, 540, 760, C.et_boucle - 0.05, 0.9);
      tl.to(["#h-cap"], { opacity: 0.4, duration: 0.4 }, C.boucle);
      tl.to(["#h-evap"], { opacity: 0.6, duration: 0.4 }, C.boucle);
      D.popIn("#in5", C.et_boucle, 0.5);
      D.glow("cold", C.boucle, 0.3, 0.4); D.glow("cream", C.boucle, 0.4, 0.4);

      // ================= 4. LA CHUTE : PORTE OUVERTE =================
      D.blurOut(["#in5", "#badges"], C.alors - 0.2, 0.15);
      zoom(0.85, 600, 760, C.alors - 0.1, 0.7);
      tl.to(["#h-cap", "#h-evap", "#frost", "#tint"], { opacity: 0, duration: 0.4 }, C.alors);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.09, ease: "power2.out" }, C.alors);
      tl.to("#door", { x: -70, rotation: -9, svgOrigin: "199 478", duration: 0.45, ease: "back.out(1.6)" }, C.ouvrir);
      { const puff = document.getElementById("puff");
        for (let j = 0; j < 7; j++) { const c = mk(puff, "circle", { r: 14 - j, cx: 200, cy: 640 + j * 60, fill: "#4cc4ff", opacity: 0 });
          tl.fromTo(c, { attr: { cx: 200 }, opacity: 0 }, { keyframes: [{ opacity: 0.8, duration: 0.12 }, { attr: { cx: 70 - j * 8 }, duration: 0.9, ease: "power2.out" }, { opacity: 0, duration: 0.3 }] }, C.ouvrir + 0.15 + j * 0.05); } }
      tl.to(["#h-cond", "#hotback"], { opacity: 0.95, duration: 0.4 }, C.ouvrir + 0.3);
      tl.to("#thermo", { opacity: 1, duration: 0.3 }, C.ouvrir + 0.2);
      tl.fromTo("#merc", { scaleY: 0.3, transformOrigin: "50% 100%" }, { scaleY: 0.95, duration: 1.6, ease: "power2.inOut" }, C.ouvrir + 0.4);
      gsap.utils.toArray("#arcs .arc").forEach((a, j) => {
        tl.to(a, { keyframes: [{ x: 0, opacity: 0, strokeWidth: 12, duration: 0.01 }, { opacity: 1, strokeWidth: 18, duration: 0.15 }, { x: 60, duration: 0.8, ease: "power1.out" }, { opacity: 0, duration: 0.2 }], repeat: 1, repeatDelay: 0.15 }, C.ouvrir + 0.4 + j * 0.25); });
      D.glow("cream", C.ouvrir, 0, 0.4); D.glow("amber", C.ouvrir + 0.3, 0.5, 0.5);
      D.blurOut("#tw-title", C.rechauffe - 0.14, 0.12);
      D.stamp("#tw-stamp span", C.rechauffe, -5);
      D.shake(C.rechauffe + 0.02, 14);
      D.flash(C.rechauffe + 0.02, 0.22, "#ff5236");
      D.glow("red", C.rechauffe, 0.8, 0.3);
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.3, ease: "power3.in" }, C.abonne - 0.32);
      tl.to("#capshade", { opacity: 0, duration: 0.2 }, C.abonne - 0.32);

      // ================= 5. CARTE DE FIN =================
      D.glow("red", C.abonne - 0.2, 0, 0.4); D.glow("amber", C.abonne - 0.2, 0, 0.4); D.glow("cold", C.abonne - 0.2, 0, 0.4);
      D.glow("cream", C.abonne - 0.2, 0.5, 0.4);
      D.endCard(C.abonne - 0.05, C.vraiment);

      // ================= sous-titres =================
      D.captions(CAP);

      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
