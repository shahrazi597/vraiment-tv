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
      #hero { position: absolute; left: -210px; top: 336px; width: 1500px; height: 844px; object-fit: cover;
        -webkit-mask-image: linear-gradient(180deg, transparent 0%, #000 30%, #000 100%);
        mask-image: linear-gradient(180deg, transparent 0%, #000 30%, #000 100%); }
      #hero-shade { position: absolute; inset: 0; background: linear-gradient(180deg, rgba(11,11,14,0) 0%, rgba(11,11,14,0) 50%, rgba(11,11,14,.6) 57%, rgba(11,11,14,1) 61.5%); }
      #h-t1 { top: 300px; font-size: 96px; }
      #h-stamp { top: 640px; }

      /* ---------- scène ---------- */
      #stage { position: absolute; left: 0; top: 0; width: 1080px; height: 1920px; }
      #stage > svg { position: absolute; left: 0; top: 0; }
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #r1 { top: 290px; height: 80px; }
      #r2 { top: 384px; height: 80px; }
      #capshade { position: absolute; left: 0; right: 0; top: 1120px; height: 800px; opacity: 0;
        background: linear-gradient(180deg, rgba(11,11,14,0) 0%, rgba(11,11,14,.92) 9%, rgba(11,11,14,.97) 100%); }

      /* frise 2024 → 2028 */
      #tline { position: absolute; left: 0; top: 0; width: 1080px; height: 1920px; opacity: 0; }
      .yr { position: absolute; width: 300px; margin-left: -150px; text-align: center; font-weight: 900; font-size: 64px; letter-spacing: -.03em; }
      .yl { position: absolute; width: 320px; margin-left: -160px; text-align: center; font-weight: 800; font-size: 30px; color: var(--muted); letter-spacing: .04em; }
      #yl26 { color: var(--amber); font-size: 36px; }

      /* nombres posés dans les hémicycles */
      #n-house { position: absolute; left: 0; right: 0; top: 770px; text-align: center; font-size: 100px; font-weight: 900; letter-spacing: -.04em; opacity: 0; }
      #l-house { position: absolute; left: 0; right: 0; top: 870px; text-align: center; font-size: 28px; font-weight: 800; letter-spacing: .12em; color: var(--muted); opacity: 0; }

      /* cartes */
      .card { position: absolute; border-radius: 44px; background: rgba(22,22,27,.97); border: 3px solid var(--line);
        opacity: 0; overflow: hidden; box-shadow: 0 40px 120px rgba(0,0,0,.55); }
      .card .k { position: absolute; left: 0; right: 0; text-align: center; font-size: 34px; font-weight: 800; letter-spacing: .16em; color: var(--amber); }
      #hist { left: 110px; top: 420px; width: 860px; height: 680px; }
      #hist .k { top: 48px; }
      #hist .big { position: absolute; top: 98px; left: 0; right: 0; text-align: center; font-size: 132px; font-weight: 900; letter-spacing: -.04em; }
      #hist .lab { position: absolute; top: 250px; left: 0; right: 0; text-align: center; font-size: 32px; font-weight: 700; color: var(--muted); }
      #hist svg { position: absolute; left: 50px; top: 310px; }
      #hist .res { position: absolute; top: 560px; left: 0; right: 0; text-align: center; font-size: 46px; font-weight: 900; opacity: 0; }
      #hist .res b { color: var(--red); }
      #hist .k, #hist .big, #hist .lab { opacity: 0; }

      .st { left: 130px; width: 820px; height: 300px; }
      #st-tx { top: 420px; }
      #st-ks { top: 760px; }
      .st .nm { position: absolute; top: 48px; left: 60px; font-size: 76px; font-weight: 900; letter-spacing: -.03em; color: var(--cold); text-transform: uppercase; }
      .st .ds { position: absolute; top: 150px; left: 60px; width: 330px; font-size: 30px; font-weight: 700; color: var(--muted); line-height: 1.25; }
      .st .yy { position: absolute; top: 70px; right: 56px; font-size: 150px; font-weight: 900; letter-spacing: -.05em; color: var(--amber); }

      #mi { left: 110px; top: 400px; width: 860px; height: 700px; }
      #mi .k { top: 50px; }
      #mi .nm { position: absolute; top: 104px; left: 0; right: 0; text-align: center; font-size: 92px; font-weight: 900; letter-spacing: -.03em; text-transform: uppercase; }
      #mi svg { position: absolute; left: 230px; top: 230px; }
      #mi .f1 { position: absolute; top: 484px; left: 0; right: 0; text-align: center; white-space: nowrap; font-size: 48px; font-weight: 900; color: var(--amber); text-transform: uppercase; letter-spacing: -.02em; }
      #mi .f2 { position: absolute; top: 566px; left: 0; right: 0; text-align: center; font-size: 38px; font-weight: 800; }
      #mi .k, #mi .nm, #mi .f1, #mi .f2 { opacity: 0; }

      /* chute */
      #tw1 { top: 300px; font-size: 88px; }
      #tw2 { top: 300px; font-size: 88px; }
      #tw1 .wsp, #tw2 .wsp { opacity: 0; }
      #law { position: absolute; left: 0; top: 0; }
      #tw-stamp { top: 330px; }
      #tw-stamp span { font-size: 72px; }
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
          <div id="hero-w"><img id="hero" src="assets/hero.jpg" alt="" /><div id="hero-shade"></div></div>
          <div id="h-t1" class="hl">Trump n'était<br />même pas sur<br />le <span class="a">bulletin…</span></div>
          <div id="h-stamp" class="stamp"><span>Congrès perdu&nbsp;!</span></div>
        </div>

        <!-- 2. Le mécanisme -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="stage">
            <svg width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <defs><filter id="soft" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="26" /></filter></defs>
              <ellipse id="hb-glow" cx="540" cy="760" rx="380" ry="230" fill="#4cc4ff" opacity="0" filter="url(#soft)" />
              <g id="house"></g>
              <g id="senate"></g>
              <g id="maj" font-family="Inter Display" font-weight="800" font-size="28" text-anchor="middle">
                <g id="mj-h" opacity="0"><line id="mjl-h" stroke="#f6f4ee" stroke-width="5" stroke-dasharray="10 8" stroke-linecap="round" /><text id="mjt-h" fill="#f6f4ee">218 = MAJORITÉ</text></g>
                <g id="mj-s" opacity="0"><line id="mjl-s" stroke="#f6f4ee" stroke-width="5" stroke-dasharray="10 8" stroke-linecap="round" /><text id="mjt-s" fill="#f6f4ee">51 = MAJORITÉ</text></g>
              </g>
            </svg>
            <div id="n-house">0</div>
            <div id="l-house">SIÈGES</div>
          </div>

          <!-- frise -->
          <div id="tline">
            <svg width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <line id="tl-line" x1="200" y1="760" x2="880" y2="760" stroke="#2a2a32" stroke-width="10" stroke-linecap="round" />
              <circle cx="220" cy="760" r="22" fill="#ece6d6" />
              <circle id="tl-26" cx="540" cy="760" r="30" fill="#ffb21f" />
              <circle cx="860" cy="760" r="22" fill="#ece6d6" />
            </svg>
            <div class="yr" style="left:220px;top:640px">2024</div>
            <div class="yr" style="left:540px;top:630px;color:var(--amber)">2026</div>
            <div class="yr" style="left:860px;top:640px">2028</div>
            <div class="yl" style="left:220px;top:810px">PRÉSIDENT<br />ÉLU</div>
            <div id="yl26" class="yl" style="left:540px;top:810px">MI-MANDAT</div>
            <div class="yl" style="left:860px;top:810px">PRÉSIDEN&shy;TIELLE</div>
          </div>

          <div id="capshade"></div>

          <div id="r1" class="row">
            <div id="c-h" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Chambre · tous les sièges en jeu</div>
            <div id="c-maj" class="chip" style="position:absolute"><i style="background:var(--cold)"></i>Majorité démocrate · Chambre ✓ Sénat ✓</div>
            <div id="c-jan" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Janvier 2027 : nouveau Congrès</div>
          </div>
          <div id="r2" class="row">
            <div id="c-s" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Sénat · 100 sièges · 1/3 en jeu</div>
          </div>

          <!-- 1946 → 2022 -->
          <div id="hist" class="card">
            <div class="k">LES MI-MANDATS DEPUIS</div>
            <div class="big" id="h-yr">1946</div>
            <div class="lab">Le parti du président à la Chambre</div>
            <svg id="h-grid" width="760" height="230" viewBox="0 0 760 230" aria-hidden="true"></svg>
            <div class="res"><b>18 fois sur 20</b> : il perd des sièges</div>
          </div>

          <!-- Texas, Kansas -->
          <div id="st-tx" class="card st">
            <div class="nm">Texas</div>
            <div class="ds">1re victoire démocrate au Sénat depuis</div>
            <div class="yy" id="y-tx">2026</div>
          </div>
          <div id="st-ks" class="card st">
            <div class="nm">Kansas</div>
            <div class="ds">1re victoire démocrate au Sénat depuis</div>
            <div class="yy" id="y-ks">2026</div>
          </div>

          <!-- Michigan -->
          <div id="mi" class="card">
            <div class="k">MICHIGAN</div>
            <div class="nm">Abdul El-Sayed</div>
            <svg width="400" height="220" viewBox="0 0 400 220" aria-hidden="true"><g id="mini"></g></svg>
            <div class="f1">Premier sénateur musulman</div>
            <div class="f2">de l'histoire des États-Unis</div>
          </div>

          <!-- chute -->
          <div id="tw1" class="hl"><span class="wsp">Trump,</span> <span class="wsp">c'est</span><br /><span class="wsp r">fini&nbsp;?</span></div>
          <div id="tw2" class="hl"><span class="wsp">Non.</span> <span class="wsp">Il</span> <span class="wsp">reste</span><br /><span class="wsp a">président.</span></div>
          <svg id="law" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="doc" opacity="0">
              <rect x="0" y="0" width="170" height="214" rx="18" fill="#ece6d6" />
              <text x="85" y="82" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="54" fill="#0b0b0e">LOI</text>
              <rect x="30" y="112" width="110" height="12" rx="6" fill="#8e8c95" />
              <rect x="30" y="140" width="110" height="12" rx="6" fill="#8e8c95" />
              <rect x="30" y="168" width="70" height="12" rx="6" fill="#8e8c95" />
              <g id="cross" opacity="0" stroke="#ff5236" stroke-width="16" stroke-linecap="round"><line x1="20" y1="20" x2="150" y2="194" /><line x1="150" y1="20" x2="20" y2="194" /></g>
            </g>
          </svg>
          <div id="tw-stamp" class="stamp"><span>Plus rien sans eux</span></div>
        </div>

        <!-- 3. Carte de fin (DA) -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Édition spéciale · Les élections de mi-mandat</div>
          <div id="c-src">Sources : Associated Press, CBS News, Roll Call (4 nov. 2026), FiveThirtyEight</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">SPÉCIAL</span>
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
      const NEUTRAL = "#3a3a44", BLUE = "#4cc4ff", AMBER = "#ffb21f", CREAM = "#ece6d6";

      // ================= hémicycles (placement classique, calculé) =================
      function hemicycle(g, n, cx, cy, r0, r1, rows, dot) {
        const radii = Array.from({ length: rows }, (_, i) => r0 + (r1 - r0) * (i / (rows - 1)));
        const tot = radii.reduce((s, r) => s + r, 0);
        const per = radii.map((r) => Math.round((n * r) / tot));
        per[rows - 1] += n - per.reduce((s, v) => s + v, 0);
        const seats = [];
        radii.forEach((r, i) => { const k = per[i]; for (let j = 0; j < k; j++) { const a = Math.PI - (Math.PI * (j + 0.5)) / k; seats.push({ a, r }); } });
        seats.sort((p, q) => q.a - p.a || p.r - q.r);
        return seats.map((s) => mk(g, "circle", { cx: (cx + s.r * Math.cos(s.a)).toFixed(1), cy: (cy - s.r * Math.sin(s.a)).toFixed(1), r: 0, fill: NEUTRAL, "data-a": s.a }));
      }
      const HC = [540, 900], SC = [540, 1100];
      const H = hemicycle(document.getElementById("house"), 435, HC[0], HC[1], 175, 380, 12, 7.4);
      const S = hemicycle(document.getElementById("senate"), 100, SC[0], SC[1], 95, 180, 6, 8.5);
      const majLine = (line, text, c, r0, r1, seats, k) => {
        const a = (parseFloat(seats[k - 1].getAttribute("data-a")) + parseFloat(seats[k].getAttribute("data-a"))) / 2;
        const p = (r) => [c[0] + r * Math.cos(a), c[1] - r * Math.sin(a)];
        const [x0, y0] = p(r0 - 18), [x1, y1] = p(r1 + 22);
        line.setAttribute("x1", x0.toFixed(1)); line.setAttribute("y1", y0.toFixed(1)); line.setAttribute("x2", x1.toFixed(1)); line.setAttribute("y2", y1.toFixed(1));
        text.setAttribute("x", x1.toFixed(1)); text.setAttribute("y", (y1 - 16).toFixed(1));
      };
      majLine(document.getElementById("mjl-h"), document.getElementById("mjt-h"), HC, 175, 380, H, 218);
      majLine(document.getElementById("mjl-s"), document.getElementById("mjt-s"), SC, 95, 180, S, 51);
      const mini = hemicycle(document.getElementById("mini"), 100, 200, 200, 90, 175, 6, 8);
      const ELS = mini[38];

      // ================= décor continu =================
      D.drift(C.end);

      // ================= 1. ACCROCHE =================
      D.glow("amber", 0, 0.35, 0.01);
      tl.fromTo("#hero", { scale: 1.06 }, { scale: 1, duration: C.comment, ease: "power1.out" }, 0);
      D.stamp("#h-stamp span", C.perdre, -5);
      D.shake(C.congres + 0.02, 10);
      D.flash(C.congres, 0.16, "#ff5236");
      D.glow("red", C.perdre, 0.5, 0.4);

      // l'image devient la frise
      const T1 = C.comment - 0.12;
      tl.to("#hero-w", { scale: 1.14, opacity: 0, duration: 0.32, ease: "power3.in" }, T1 - 0.1);
      D.blurOut(["#h-t1", "#h-stamp span"], T1 - 0.1, 0.18);
      D.glow("red", T1, 0, 0.4); D.glow("amber", T1, 0.3, 0.4);
      tl.to("#capshade", { opacity: 1, duration: 0.3 }, T1 + 0.1);

      // ================= 2. MI-MANDAT : 2024 → 2026 → 2028 =================
      tl.fromTo("#tline", { opacity: 0, filter: "blur(12px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.4, ease: "expo.out" }, T1 + 0.05);
      tl.fromTo("#tl-26", { attr: { r: 30 } }, { keyframes: [{ attr: { r: 40 }, duration: 0.15 }, { attr: { r: 30 }, duration: 0.35, ease: "back.out(2)" }] }, C.mimandat);
      D.glow("amber", C.mimandat, 0.6, 0.4);
      D.blurOut("#tline", C.tous - 0.12, 0.18);

      // ================= 3. LA CHAMBRE : 435 SIÈGES, TOUS EN JEU =================
      D.glow("amber", C.tous, 0.2, 0.4); D.glow("cream", C.tous, 0.4, 0.4);
      tl.to(H, { attr: { r: 7.4 }, duration: 0.25, ease: "back.out(2)", stagger: { amount: 1.0 } }, C.tous);
      tl.to(H, { attr: { fill: AMBER }, duration: 0.12, stagger: { amount: 0.6 } }, C.toute - 0.05);
      D.popIn("#c-h", C.chambre, 0.6);
      tl.fromTo(["#n-house", "#l-house"], { opacity: 0 }, { opacity: 1, duration: 0.25 }, C.n435 - 0.4);
      D.count("n-house", 0, 435, C.n435 - 0.4, 1.1, 0);
      tl.to(H, { attr: { fill: NEUTRAL }, duration: 0.3 }, C.et_senat - 0.1);

      // ================= 4. LE SÉNAT : UN TIERS EN JEU =================
      tl.to(S, { attr: { r: 8.5 }, duration: 0.25, ease: "back.out(2)", stagger: { amount: 0.5 } }, C.et_senat);
      const third = S.filter((_, i) => i % 3 === 0);
      tl.to(third, { attr: { fill: AMBER }, duration: 0.12, stagger: { amount: 0.3 } }, C.tiers - 0.05);
      D.popIn("#c-s", C.tiers, 0.6);

      // ================= 5. DEPUIS 1946 : LE PARTI DU PRÉSIDENT RECULE =================
      const OUT1 = C.depuis - 0.2;
      D.blurOut(["#c-h", "#c-s", "#n-house", "#l-house"], OUT1, 0.15);
      tl.to(["#house", "#senate"], { opacity: 0.12, duration: 0.3 }, OUT1);
      D.glow("cream", OUT1, 0.25, 0.4);
      tl.fromTo("#hist", { opacity: 0, scale: 0.9, y: 40 }, { opacity: 1, scale: 1, y: 0, duration: 0.35, ease: "expo.out" }, OUT1 + 0.05);
      D.blurIn("#hist .k", C.depuis);
      D.blurIn("#hist .big", C.y1946 - 0.05);
      D.blurIn("#hist .lab", C.parti - 0.1);
      { const grid = document.getElementById("h-grid"); const YEARS = [];
        for (let y = 1946; y <= 2022; y += 4) YEARS.push(y);
        const EXC = [1998, 2002], t0 = C.y1946 + 0.35, span = (C.chambre_end || (C.sauf - 0.25)) - t0;
        YEARS.forEach((y, i) => { const col = i % 10, row = Math.floor(i / 10), x = 38 + col * 76, yy = 50 + row * 112;
          const g = mk(grid, "g", { opacity: 0 });
          const exc = EXC.includes(y);
          mk(g, "rect", { x: x - 32, y: yy - 42, width: 64, height: 64, rx: 14, fill: "#0b0b0e", stroke: exc ? AMBER : "#2a2a32", "stroke-width": 3 });
          mk(g, "path", { d: exc ? `M${x - 18} ${yy + 4} L${x} ${yy - 22} L${x + 18} ${yy + 4} Z` : `M${x - 18} ${yy - 18} L${x} ${yy + 8} L${x + 18} ${yy - 18} Z`, fill: exc ? AMBER : "#ff5236" });
          const tx = mk(g, "text", { x, y: yy + 62, "text-anchor": "middle", "font-family": "Inter Display", "font-weight": 800, "font-size": 28, fill: exc ? AMBER : "#8e8c95" });
          tx.textContent = "’" + String(y).slice(2);
          if (exc) gsap.set(g, { svgOrigin: `${x} ${yy}` });
          if (exc) tl.fromTo(g, { opacity: 0, scale: 0.4 }, { opacity: 1, scale: 1, duration: 0.4, ease: "back.out(2.6)" }, C.sauf + (y === 2002 ? 0.12 : 0));
          else tl.fromTo(g, { opacity: 0, y: -18 }, { opacity: 1, y: 0, duration: 0.18, ease: "power2.out" }, t0 + (span * i) / YEARS.length); });
        { const o = { i: 0 }, el = document.getElementById("h-yr"), n = YEARS.length;
          tl.to(o, { i: n - 1, duration: span * (n - 1) / n, ease: "none", onUpdate: () => (el.textContent = YEARS[Math.floor(o.i + 1e-6)]) }, t0); } }
      D.glow("red", C.perd - 0.1, 0.35, 0.4);
      D.glow("amber", C.sauf, 0.55, 0.3);
      tl.fromTo("#hist .res", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.25 }, C.fois);
      // la carte se range
      tl.to("#hist", { scale: 0.2, y: 260, opacity: 0, filter: "blur(10px)", duration: 0.4, ease: "power3.in" }, C.historique - 0.35);

      // ================= 6. HISTORIQUE : LES DÉMOCRATES PRENNENT LES DEUX CHAMBRES =================
      tl.to(["#house", "#senate"], { opacity: 1, duration: 0.35 }, C.historique - 0.1);
      tl.to(third, { attr: { fill: NEUTRAL }, duration: 0.2 }, C.historique - 0.1);
      D.glow("red", C.mais, 0, 0.4); D.glow("amber", C.mais, 0, 0.4); D.glow("cream", C.mais, 0.2, 0.4);
      D.glow("cold", C.historique, 0.55, 0.4);
      tl.to(H.slice(0, 218), { attr: { fill: BLUE }, duration: 0.1, stagger: { amount: 0.75 } }, C.democrates);
      tl.to(S.slice(0, 51), { attr: { fill: BLUE }, duration: 0.1, stagger: { amount: 0.55 } }, C.prennent);
      tl.to("#hb-glow", { opacity: 0.35, duration: 0.5 }, C.prennent);
      tl.fromTo(["#mj-h", "#mj-s"], { opacity: 0 }, { opacity: 1, duration: 0.25, stagger: 0.1 }, C.chambres - 0.1);
      D.popIn("#c-maj", C.chambres, 0.6);
      D.shake(C.chambres + 0.05, 12);
      D.flash(C.chambres + 0.05, 0.16, "#4cc4ff");
      D.glow("cold", C.chambres, 0.8, 0.3);

      // ================= 7. TEXAS (1988) ET KANSAS (1932) =================
      const OUT2 = C.ils - 0.1;
      D.blurOut(["#mj-h", "#mj-s"], OUT2, 0.15);
      D.blurOut("#c-maj", C.et_mi - 0.2, 0.15);
      tl.to(["#house", "#senate"], { opacity: 0.1, duration: 0.3 }, OUT2);
      tl.to("#hb-glow", { opacity: 0, duration: 0.3 }, OUT2);
      tl.fromTo("#st-tx", { opacity: 0, x: -120 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.texas - 0.15);
      D.count("y-tx", 2026, 1988, C.depuis_tx, 0.9, 0);
      tl.fromTo("#y-tx", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.1 }, { scale: 1, duration: 0.3, ease: "back.out(2)" }] }, C.depuis_tx + 0.9);
      tl.fromTo("#st-ks", { opacity: 0, x: 120 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.kansas - 0.15);
      D.count("y-ks", 2026, 1932, C.depuis_ks, 0.9, 0);
      tl.fromTo("#y-ks", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.1 }, { scale: 1, duration: 0.3, ease: "back.out(2)" }] }, C.depuis_ks + 0.9);
      D.glow("amber", C.y1988, 0.4, 0.4);

      // ================= 8. MICHIGAN : ABDUL EL-SAYED =================
      tl.to(["#st-tx", "#st-ks"], { opacity: 0, scale: 0.9, filter: "blur(10px)", duration: 0.25, ease: "power2.in" }, C.et_mi - 0.2);
      D.glow("amber", C.et_mi, 0.15, 0.4); D.glow("cold", C.et_mi, 0.4, 0.4);
      tl.fromTo("#mi", { opacity: 0, scale: 0.9, y: 40 }, { opacity: 1, scale: 1, y: 0, duration: 0.35, ease: "expo.out" }, C.et_mi);
      D.blurIn("#mi .k", C.michigan - 0.05);
      D.blurIn("#mi .nm", C.abdul - 0.05, 0.22);
      tl.to(mini, { attr: { r: 8 }, duration: 0.2, ease: "back.out(2)", stagger: { amount: 0.6 } }, C.abdul + 0.1);
      tl.to(mini.slice(0, 51), { attr: { fill: BLUE }, duration: 0.1, stagger: { amount: 0.3 } }, C.devient);
      tl.to(ELS, { attr: { fill: AMBER, r: 15 }, duration: 0.35, ease: "back.out(3)" }, C.musulman - 0.05);
      D.blurIn("#mi .f1", C.musulman - 0.05, 0.22);
      D.blurIn("#mi .f2", C.etatsunis - 0.15);
      D.glow("amber", C.musulman, 0.6, 0.3);

      // ================= 9. LA CHUTE =================
      tl.to("#mi", { opacity: 0, scale: 0.9, filter: "blur(10px)", duration: 0.25, ease: "power2.in" }, C.alors + 0.4);
      D.glow("amber", C.alors, 0, 0.4); D.glow("cold", C.alors, 0.25, 0.4);
      tl.fromTo("#tw1 .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.14, ease: "power2.out" }, C.alors + 0.62);
      D.blurOut("#tw1", C.non - 0.12, 0.12);
      tl.fromTo("#tw2 .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.12, ease: "power2.out" }, C.non);
      D.glow("amber", C.reste, 0.4, 0.4);
      // le nouveau Congrès revient, tout bleu
      D.blurOut("#tw2", C.janvier - 0.4, 0.15);
      tl.to(["#house", "#senate"], { opacity: 1, duration: 0.35 }, C.janvier - 0.3);
      tl.to("#hb-glow", { opacity: 0.3, duration: 0.35 }, C.janvier - 0.3);
      D.popIn("#c-jan", C.janvier - 0.1, 0.6);
      // une loi arrive… et bute sur le Congrès
      gsap.set("#doc", { svgOrigin: "85 107" });
      tl.fromTo("#doc", { opacity: 0, x: -220, y: 560, rotation: 0 },
        { opacity: 1, x: 70, y: 560, duration: 0.45, ease: "power2.out" }, C.loi - 0.3);
      tl.to("#doc", { keyframes: [{ x: 150, duration: 0.16, ease: "power2.in" }, { x: 30, rotation: -10, duration: 0.3, ease: "back.out(2)" }] }, C.passe - 0.05);
      tl.to(H.slice(0, 218), { attr: { r: 9 }, duration: 0.12, yoyo: true, repeat: 1 }, C.passe + 0.1);
      tl.to("#cross", { opacity: 1, duration: 0.15 }, C.sans - 0.1);
      D.blurOut("#c-jan", C.sans - 0.2, 0.12);
      D.stamp("#tw-stamp span", C.sans, -5);
      D.shake(C.sans + 0.02, 12);
      D.flash(C.sans + 0.02, 0.2, "#ff5236");
      D.glow("red", C.sans, 0.6, 0.3);
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.3, ease: "power3.in" }, C.abonne - 0.32);
      tl.to("#capshade", { opacity: 0, duration: 0.2 }, C.abonne - 0.32);

      // ================= 10. CARTE DE FIN =================
      D.glow("red", C.abonne - 0.2, 0, 0.4); D.glow("cold", C.abonne - 0.2, 0, 0.4);
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
