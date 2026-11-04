<!doctype html>
<html lang="fr" data-resolution="portrait">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <script src="assets/gsap.min.js"></script>
    <style>
      @font-face { font-family: "Inter Display"; font-weight: 600; src: url("assets/fonts/InterDisplay-SemiBold.otf"); }
      @font-face { font-family: "Inter Display"; font-weight: 700; src: url("assets/fonts/InterDisplay-Bold.otf"); }
      @font-face { font-family: "Inter Display"; font-weight: 800; src: url("assets/fonts/InterDisplay-ExtraBold.otf"); }
      @font-face { font-family: "Inter Display"; font-weight: 900; src: url("assets/fonts/InterDisplay-Black.otf"); }
      :root {
        --ground: #0b0b0e;
        --panel: #16161b;
        --line: #2a2a32;
        --ink: #f6f4ee;
        --muted: #8e8c95;
        --dim: #75737c;
        --fuel: #ece6d6;
        --accise: #ff5236;
        --tva: #ffb21f;
        --font: "Inter Display", sans-serif;
      }
      * { margin: 0; padding: 0; box-sizing: border-box; }
      html, body { width: 1080px; height: 1920px; overflow: hidden; background: var(--ground); }
      #root { position: relative; width: 1080px; height: 1920px; overflow: hidden;
        font-family: var(--font); color: var(--ink); font-variant-numeric: tabular-nums; }
      .clip { position: absolute; inset: 0; }
      .abs { position: absolute; }

      /* ---------- décor ---------- */
      #grid { position: absolute; left: -100px; top: -240px; width: 1280px; height: 2480px;
        background-image: linear-gradient(rgba(255,255,255,.045) 2px, transparent 2px),
                          linear-gradient(90deg, rgba(255,255,255,.045) 2px, transparent 2px);
        background-size: 80px 80px; }
      .glow { position: absolute; left: -210px; top: 60px; width: 1500px; height: 1500px; opacity: 0; }
      #gl-fuel { background: radial-gradient(circle, rgba(236,230,214,.30) 0%, rgba(236,230,214,0) 58%); }
      #gl-acc  { background: radial-gradient(circle, rgba(255,82,54,.42) 0%, rgba(255,82,54,0) 58%); }
      #gl-tva  { background: radial-gradient(circle, rgba(255,178,31,.38) 0%, rgba(255,178,31,0) 58%); }
      #gl-gold { background: radial-gradient(circle, rgba(255,178,31,.30) 0%, rgba(255,178,31,0) 55%); }
      #vign { position: absolute; inset: 0; background: radial-gradient(ellipse 75% 60% at 50% 42%, rgba(0,0,0,0) 55%, rgba(0,0,0,.6) 100%); }
      #flash { position: absolute; inset: 0; background: var(--accise); opacity: 0; mix-blend-mode: screen; }

      #cam { position: absolute; inset: 0; transform-origin: 540px 760px; }

      /* ---------- série ---------- */
      #tag { position: absolute; top: 192px; left: 0; right: 0; bottom: auto; height: 64px; display: flex; justify-content: center; gap: 12px; }
      #tag .pill { font-size: 30px; font-weight: 800; letter-spacing: .04em; padding: 14px 28px; border-radius: 999px;
        background: var(--ink); color: var(--ground); white-space: nowrap; }
      #tag .num { background: var(--accise); color: var(--ground); }

      /* ---------- accroche ---------- */
      .hl { position: absolute; left: 0; right: 0; text-align: center; font-weight: 900; text-transform: uppercase;
        letter-spacing: -.03em; line-height: .98; font-size: 104px; }
      #h-l1 { top: 360px; }
      #h-l2 { top: 360px; }
      #h-l2 span, .wsp { display: inline-block; }
      #h-l2 { opacity: 1; }
      #h-l2 .wsp { opacity: 0; }
      #h-price { position: absolute; left: 40px; top: 640px; width: 1000px; height: 330px; }
      .half { position: absolute; inset: 0; text-align: center; font-size: 330px; font-weight: 900; line-height: 1;
        letter-spacing: -.05em; color: var(--tva); white-space: nowrap; }
      #h-pl, #h-pr { opacity: 0; }
      #h-pl { clip-path: polygon(0 0, 56% 0, 44% 100%, 0 100%); }
      #h-pr { clip-path: polygon(56% 0, 100% 0, 100% 100%, 44% 100%); }
      #h-slash { position: absolute; left: 491px; top: -45px; width: 18px; height: 420px; border-radius: 9px; background: var(--accise);
        transform-origin: 50% 50%; opacity: 0; }
      #h-stamp { position: absolute; top: 1030px; left: 0; right: 0; display: flex; justify-content: center; }
      #h-stamp span { display: block; font-size: 82px; font-weight: 900; text-transform: uppercase; letter-spacing: -.02em;
        color: var(--ground); background: var(--accise); padding: 18px 40px; border-radius: 22px; white-space: nowrap; opacity: 0; }

      /* ---------- pompe ---------- */
      #pump { position: absolute; left: 80px; top: 280px; width: 920px; height: 200px; border-radius: 34px;
        background: linear-gradient(180deg, #1b1b21, #131317); border: 3px solid var(--line);
        display: flex; align-items: center; gap: 30px; padding: 0 44px 0 36px; transform-origin: 50% 0%; opacity: 0;
        box-shadow: 0 30px 80px rgba(0,0,0,.45); }
      #pump svg { flex: none; }
      #pump .col { display: flex; flex-direction: column; gap: 10px; }
      #pump .col.r { margin-left: auto; align-items: flex-end; }
      #pump .lbl { white-space: nowrap; font-size: 34px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: var(--muted); }
      #pump .mid { font-size: 62px; font-weight: 800; letter-spacing: -.03em; line-height: 1; color: var(--muted); }
      #pump .big { font-size: 100px; font-weight: 900; letter-spacing: -.045em; line-height: 1; }

      /* ---------- réservoir ---------- */
      #tank { position: absolute; left: 90px; top: 490px; width: 330px; height: 640px; border-radius: 44px;
        border: 5px solid var(--line); background: #111115; overflow: hidden; opacity: 0; }
      .layer { position: absolute; left: 0; width: 320px; }
      #ly-fuel { bottom: 0; height: 315px; z-index: 3; background: linear-gradient(180deg, #f4efe2, #d8d0bb); }
      #ly-acc  { bottom: 315px; height: 210px; z-index: 2; background: linear-gradient(180deg, #ff6c4e, #e43a1f); }
      #ly-tva  { bottom: 525px; height: 105px; z-index: 1; background: linear-gradient(180deg, #ffc451, #f39a00); }
      .wave { position: absolute; left: 0; top: -26px; width: 660px; height: 28px; overflow: visible; }
      .pct { position: absolute; left: 0; right: 0; top: 50%; margin-top: -34px; text-align: center; font-size: 60px; font-weight: 900;
        letter-spacing: -.03em; color: rgba(11,11,14,.85); opacity: 0; }
      .bub { position: absolute; bottom: 10px; width: 16px; height: 16px; border-radius: 50%; background: rgba(11,11,14,.13); opacity: 0; }
      #taxtax { position: absolute; left: 22px; width: 286px; top: 62px; text-align: center; z-index: 5; opacity: 0;
        font-size: 34px; line-height: 1.05; font-weight: 900; text-transform: uppercase; color: var(--ground);
        background: var(--tva); border: 4px solid var(--ground); border-radius: 18px; padding: 12px 10px; }

      .label { position: absolute; left: 470px; width: 450px; opacity: 0; }
      .label .name { display: flex; align-items: center; gap: 14px; font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; }
      .label .name i { display: block; width: 22px; height: 22px; border-radius: 6px; }
      .label .sub { font-size: 28px; font-weight: 600; color: var(--muted); margin-top: 4px; }
      .label .val { font-size: 100px; font-weight: 900; letter-spacing: -.045em; line-height: 1.02; margin-top: 2px; white-space: nowrap; }
      #l-fuel { top: 826px; }
      #l-fuel .val { color: var(--fuel); }
      #l-acc { top: 610px; }
      #l-acc .val { color: var(--accise); font-size: 92px; }
      #l-tva { top: 470px; }
      #l-tva .val { color: var(--tva); font-size: 84px; }
      #ul { width: 330px; height: 10px; border-radius: 5px; background: var(--fuel); margin-top: 2px; transform-origin: 0 50%; }
      .chips { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 16px; width: 440px; }
      .chip { font-size: 29px; font-weight: 700; padding: 9px 20px; border-radius: 999px; background: var(--panel);
        border: 3px solid var(--line); opacity: 0; }

      /* ---------- bilan ---------- */
      #b-title { position: absolute; top: 300px; left: 0; right: 0; text-align: center; font-size: 168px; font-weight: 900;
        letter-spacing: -.05em; line-height: 1; text-transform: uppercase; white-space: nowrap; }
      #b-title span { display: inline-block; opacity: 0; }
      #b-title .a { color: var(--tva); }
      #coin { position: absolute; left: 320px; top: 520px; width: 440px; height: 440px; opacity: 0; }
      .ch { position: absolute; top: 0; width: 220px; height: 440px; overflow: hidden; }
      #ch-l { left: 0; }
      #ch-r { left: 220px; }
      .ch svg { position: absolute; top: 0; width: 440px; height: 440px; }
      #ch-r svg { left: -220px; }
      .tint { position: absolute; inset: 0; opacity: 0; mix-blend-mode: multiply; }
      #ch-l .tint { background: #e7dcc0; }
      #ch-r .tint { background: #ff4a2c; }
      .blab { position: absolute; top: 1000px; width: 380px; text-align: center; opacity: 0; }
      .blab .k { font-size: 32px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); }
      .blab .v { font-size: 78px; font-weight: 900; letter-spacing: -.04em; line-height: 1.05; }
      #bl-l { left: 160px; }
      #bl-l .v { color: var(--fuel); }
      #bl-r { left: 540px; }
      #bl-r .v { color: var(--accise); }
      #bl-r .k b { color: var(--tva); font-weight: 900; }

      /* ---------- fin ---------- */
      #c-title { position: absolute; top: 380px; left: 0; right: 0; text-align: center; font-size: 126px; font-weight: 900;
        letter-spacing: -.045em; line-height: 1.0; text-transform: uppercase; }
      #c-title div { opacity: 0; }
      #c-title .a { color: var(--tva); }
      #c-btn { position: absolute; top: 820px; left: 0; right: 0; display: flex; justify-content: center; }
      #c-btn span { display: block; font-size: 66px; font-weight: 900; padding: 30px 74px; border-radius: 999px;
        background: var(--accise); color: var(--ground); opacity: 0; box-shadow: 0 20px 60px rgba(255,82,54,.35); }
      #c-ep { position: absolute; top: 990px; left: 0; right: 0; text-align: center; font-size: 36px; font-weight: 800; color: var(--ink); opacity: 0; }
      #c-src { position: absolute; top: 1060px; left: 140px; right: 140px; text-align: center; font-size: 29px; font-weight: 600;
        color: var(--muted); line-height: 1.35; opacity: 0; }

      /* ---------- sous-titres ---------- */
      #caps { position: absolute; left: 0; right: 0; top: 1180px; bottom: auto; height: 150px; }
      .cap { position: absolute; left: 0; right: 0; top: 0; text-align: center; font-size: 66px; font-weight: 900;
        letter-spacing: -.02em; white-space: nowrap; opacity: 0; color: var(--dim); }
      .cap .wd { display: inline-block; margin: 0 .07em; }
      .label .val { opacity: 0; }
      .cap .in { display: inline-block; }
    </style>
  </head>
  <body>
    <div id="root" data-composition-id="main" data-start="0" data-duration="%%END%%" data-width="1080" data-height="1920">
%%AUDIO%%

      <div id="bg" class="clip" data-start="0" data-duration="%%END%%" data-track-index="0" data-track-kind="graphics">
        <div id="grid"></div>
        <div id="gl-fuel" class="glow"></div>
        <div id="gl-acc" class="glow"></div>
        <div id="gl-tva" class="glow"></div>
        <div id="gl-gold" class="glow"></div>
        <div id="vign"></div>
      </div>

      <div id="cam">
        <!-- Accroche -->
        <div id="s-hook" class="clip" data-start="0" data-duration="%%HOOK_D%%" data-track-index="1" data-track-kind="graphics">
          <div id="h-l1" class="hl">Ton plein<br />d'essence&nbsp;?</div>
          <div id="h-l2" class="hl"><span class="wsp">Et</span> <span class="wsp">l'essence</span><br /><span class="wsp">elle-même&nbsp;?</span></div>
          <div id="h-price">
            <div id="h-pw" class="half">124&nbsp;€</div>
            <div id="h-pl" class="half">124&nbsp;€</div>
            <div id="h-pr" class="half">124&nbsp;€</div>
            <div id="h-slash"></div>
          </div>
          <div id="h-stamp"><span>Même pas la moitié&nbsp;!</span></div>
        </div>

        <!-- Pompe + réservoir -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="pump">
            <svg width="100" height="120" viewBox="0 0 102 120" aria-hidden="true">
              <rect x="6" y="10" width="58" height="104" rx="10" fill="#ff5236" />
              <rect x="16" y="22" width="38" height="26" rx="5" fill="#0b0b0e" />
              <rect x="20" y="28" width="22" height="6" rx="3" fill="#ffb21f" />
              <rect x="0" y="106" width="70" height="12" rx="4" fill="#2a2a32" />
              <path d="M64 40 h12 a10 10 0 0 1 10 10 v40 a6 6 0 0 0 12 0 v-50 l-10 -14" fill="none" stroke="#f6f4ee" stroke-width="6" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
            <div class="col">
              <div class="lbl">SP95 · France</div>
              <div class="mid"><span id="p-l">0,00</span>&nbsp;L</div>
            </div>
            <div class="col r">
              <div class="lbl">À payer</div>
              <div class="big"><span id="p-e">0,00</span>&nbsp;€</div>
            </div>
          </div>

          <div id="tank">
            <div id="ly-fuel" class="layer">
              <svg class="wave" viewBox="0 0 660 28" preserveAspectRatio="none"><path id="wv-fuel" fill="#f4efe2" /></svg>
              <div class="bub" style="left:40px"></div><div class="bub" style="left:96px"></div><div class="bub" style="left:150px"></div>
              <div class="bub" style="left:205px"></div><div class="bub" style="left:258px"></div><div class="bub" style="left:120px"></div>
              <div id="pc-fuel" class="pct">50&nbsp;%</div>
            </div>
            <div id="ly-acc" class="layer">
              <svg class="wave" viewBox="0 0 660 28" preserveAspectRatio="none"><path id="wv-acc" fill="#ff6c4e" /></svg>
              <div id="pc-acc" class="pct">33&nbsp;%</div>
              <div id="taxtax">Taxe sur<br />la taxe</div>
            </div>
            <div id="ly-tva" class="layer">
              <svg class="wave" viewBox="0 0 660 28" preserveAspectRatio="none"><path id="wv-tva" fill="#ffc451" /></svg>
              <div id="pc-tva" class="pct">17&nbsp;%</div>
            </div>
          </div>

          <div id="l-tva" class="label">
            <div class="name"><i style="background:var(--tva)"></i>TVA 20&nbsp;%</div>
            <div class="val"><span id="v-tva">0,00</span>&nbsp;€</div>
          </div>
          <div id="l-acc" class="label">
            <div class="name"><i style="background:var(--accise)"></i>L'accise</div>
            <div class="sub">la taxe carburant</div>
            <div class="val"><span id="v-acc">0,00</span>&nbsp;€</div>
          </div>
          <div id="l-fuel" class="label">
            <div class="name"><i style="background:var(--fuel)"></i>Le carburant</div>
            <div class="val"><span id="v-fuel">0,00</span>&nbsp;€</div>
            <div id="ul"></div>
            <div class="chips">
              <span id="ch1" class="chip">pétrole</span><span id="ch2" class="chip">raffinage</span>
              <span id="ch3" class="chip">transport</span><span id="ch4" class="chip">station</span>
            </div>
          </div>
        </div>

        <!-- Bilan -->
        <div id="s-bilan" class="clip" data-start="%%BIL_S%%" data-duration="%%BIL_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="b-title"><span class="a">1&nbsp;€</span> <span>sur</span> <span>2</span></div>
          <div id="coin">
            <div id="ch-l" class="ch">
              <svg viewBox="0 0 440 440"><use href="#coinface" /><circle id="tn-l" cx="220" cy="220" r="216" fill="#efe6cf" opacity="0" /></svg>
            </div>
            <div id="ch-r" class="ch">
              <svg viewBox="0 0 440 440"><use href="#coinface" /><circle id="tn-r" cx="220" cy="220" r="216" fill="#ff5236" opacity="0" /></svg>
            </div>
          </div>
          <div id="bl-l" class="blab"><div class="k">Carburant</div><div class="v">61,74&nbsp;€</div></div>
          <div id="bl-r" class="blab"><div class="k">Taxes <b id="to-etat">→ l'État</b></div><div class="v">62,04&nbsp;€</div></div>
        </div>

        <!-- Fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="4" data-track-kind="graphics">
          <div id="c-title"><div>Combien ça</div><div>coûte</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 1 · Le plein d'essence</div>
          <div id="c-src">Source : Commission européenne (Weekly Oil Bulletin), prix moyens France au 24/08/2026</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMBIEN ÇA COÛTE VRAIMENT&nbsp;?</span><span class="pill num">#1</span>
      </div>

      <div id="fx" class="clip" data-start="0" data-duration="%%END%%" data-track-index="7" data-track-kind="graphics">
        <div id="flash"></div>
      </div>

      <svg width="0" height="0" style="position:absolute" aria-hidden="true">
        <defs>
          <radialGradient id="gGold" cx="40%" cy="35%" r="75%">
            <stop offset="0%" stop-color="#ffe08a" /><stop offset="55%" stop-color="#e3a920" /><stop offset="100%" stop-color="#9c6a06" />
          </radialGradient>
          <radialGradient id="gSilver" cx="40%" cy="35%" r="75%">
            <stop offset="0%" stop-color="#ffffff" /><stop offset="60%" stop-color="#c9cad1" /><stop offset="100%" stop-color="#8a8c94" />
          </radialGradient>
          <g id="coinface">
            <circle cx="220" cy="220" r="216" fill="url(#gGold)" />
            <circle cx="220" cy="220" r="200" fill="none" stroke="rgba(120,80,0,.45)" stroke-width="4" />
            <circle cx="220" cy="220" r="150" fill="url(#gSilver)" />
            <circle cx="220" cy="220" r="150" fill="none" stroke="rgba(0,0,0,.18)" stroke-width="4" />
            <text x="220" y="262" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="150" fill="#3c3d44" letter-spacing="-6">1€</text>
          </g>
        </defs>
      </svg>
    </div>

    <script>
      const C = %%CUES%%;
      const CAP = %%CAPDATA%%;
      const fr = (v, d) => v.toFixed(d).replace(".", ",");
      // ajuste chaque groupe à la largeur utile (mesuré une fois, au chargement)
      CAP.forEach((g) => {
        const el = document.getElementById(g.id);
        const inner = el.querySelector(".in");
        let fs = 66;
        while (inner.getBoundingClientRect().width > 860 && fs > 44) { fs -= 2; el.style.fontSize = fs + "px"; }
      });

      const tl = gsap.timeline({ paused: true });

      // ---------- outils ----------
      const count = (id, to, at, dur, d = 2) => {
        const o = { v: 0 }, el = document.getElementById(id);
        tl.to(o, { v: to, duration: dur, ease: "power2.out", onUpdate: () => (el.textContent = fr(o.v, d)) }, at);
      };
      const blurIn = (sel, at, d = 0.2, extra = {}) =>
        tl.fromTo(sel, { opacity: 0, filter: "blur(10px)" }, { opacity: 1, filter: "blur(0px)", duration: d, ease: "power2.out", ...extra }, at);
      const blurOut = (sel, at, d = 0.15) => tl.to(sel, { opacity: 0, filter: "blur(10px)", duration: d, ease: "power2.in" }, at);
      const popIn = (sel, at, from = 0.6) =>
        tl.fromTo(sel, { opacity: 0, scale: from }, { opacity: 1, scale: 1, duration: 0.38, ease: "back.out(2.2)" }, at);
      const shake = (at, a = 14) =>
        tl.to("#cam", { keyframes: [
          { x: a, y: -a * 0.6, duration: 0.035 }, { x: -a * 0.8, y: a * 0.5, duration: 0.035 },
          { x: a * 0.5, y: a * 0.4, duration: 0.035 }, { x: -a * 0.3, y: -a * 0.3, duration: 0.035 },
          { x: 0, y: 0, duration: 0.05 } ] }, at);
      const flash = (at, o = 0.22) => tl.to("#flash", { keyframes: [{ opacity: o, duration: 0.03 }, { opacity: 0, duration: 0.35, ease: "power2.out" }] }, at);
      const glow = (id, at, o = 1, d = 0.45) => tl.to(id, { opacity: o, duration: d, ease: "power2.inOut" }, at);

      // vagues : même dessin pour chaque couche, défilement linéaire fini
      const wave = () => {
        let d = "M0 28 L0 14";
        for (let x = 0; x <= 660; x += 6) d += ` L${x} ${(14 + 7 * Math.sin((x / 165) * Math.PI * 2)).toFixed(2)}`;
        return d + " L660 28 Z";
      };
      ["wv-fuel", "wv-acc", "wv-tva"].forEach((id) => document.getElementById(id).setAttribute("d", wave()));
      const reps = Math.ceil(C.end / 1.1);
      tl.fromTo(".wave", { x: 0 }, { x: -165, duration: 1.1, ease: "none", repeat: reps }, 0);

      // décor continu
      tl.fromTo("#grid", { y: 0 }, { y: -160, duration: C.end, ease: "none" }, 0);
      glow("#gl-gold", 0, 1, 0.01);

      // ---------- 1. accroche ----------
      tl.fromTo("#h-price", { scale: 1 }, { keyframes: [{ scale: 1.16, duration: 0.09, ease: "power2.out" }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.p124 - 0.05);
      shake(C.p124 - 0.02, 10);
      flash(C.p124 - 0.02, 0.12);
      blurOut("#h-l1", C.mais - 0.08, 0.14);
      tl.fromTo("#h-l2 .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.09, ease: "power2.out" }, C.mais);
      tl.fromTo("#h-slash", { opacity: 0, rotation: 20, scaleY: 0 }, { opacity: 1, rotation: 20, scaleY: 1, duration: 0.16, ease: "expo.out" }, C.moitie - 0.22);
      tl.fromTo(["#h-pl", "#h-pr"], { opacity: 0 }, { opacity: 1, duration: 0.01 }, C.moitie - 0.22);
      tl.fromTo("#h-pw", { opacity: 1 }, { opacity: 0, duration: 0.01 }, C.moitie - 0.21);
      tl.to("#h-pr", { y: 520, x: 60, rotation: 24, opacity: 0, duration: 0.7, ease: "power3.in" }, C.moitie - 0.05);
      tl.to("#h-pl", { color: "#ece6d6", duration: 0.3 }, C.moitie);
      tl.fromTo("#h-stamp span", { opacity: 0, scale: 2.3, rotation: -14 }, { opacity: 1, scale: 1, rotation: -5, duration: 0.24, ease: "expo.out" }, C.moitie);
      shake(C.moitie + 0.02, 18);
      flash(C.moitie + 0.02, 0.28);
      glow("#gl-gold", C.moitie, 0, 0.4);
      glow("#gl-acc", C.moitie, 0.7, 0.3);
      tl.to("#s-hook", { y: -260, opacity: 0, filter: "blur(14px)", duration: 0.26, ease: "power3.in" }, C.l60 - 0.32);
      glow("#gl-acc", C.l60 - 0.3, 0, 0.4);

      // ---------- 2. la pompe ----------
      tl.fromTo("#pump", { opacity: 0, y: 520, scale: 1.12, filter: "blur(14px)" },
        { opacity: 1, y: 380, scale: 1.12, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, C.l60 - 0.12);
      glow("#gl-fuel", C.l60 - 0.1, 0.6);
      const tPay = Math.max(1.0, C.p12378 - C.l60 + 0.35);
      count("p-l", 60, C.l60, tPay);
      count("p-e", 123.78, C.l60, tPay);
      tl.fromTo("#pump .big", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.08 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, C.l60 + tPay);
      tl.fromTo("#pump .big", { color: "#ffb21f" }, { color: "#f6f4ee", duration: 0.6 }, C.l60 + tPay);

      // ---------- 3. le carburant ----------
      const tCar = C.carburant - 0.35;
      tl.to("#pump", { y: 0, scale: 0.82, duration: 0.5, ease: "power3.inOut" }, tCar);
      tl.fromTo("#tank", { opacity: 0, y: 140 }, { opacity: 1, y: 0, duration: 0.5, ease: "expo.out" }, tCar + 0.1);
      tl.fromTo("#ly-fuel", { y: 330 }, { y: 0, duration: 1.2, ease: "power2.out" }, C.carburant);
      tl.fromTo("#ly-fuel .bub", { y: 0, opacity: 0 }, { keyframes: [{ opacity: 1, duration: 0.15 }, { y: -260, opacity: 0, duration: 1.3, ease: "power1.out" }], stagger: 0.12 }, C.carburant + 0.1);
      blurIn("#l-fuel", C.carburant);
      ["petrole", "raffinage", "transport", "station"].forEach((k, i) => popIn(`#ch${i + 1}`, C[k] - 0.03, 0.4));
      blurIn("#l-fuel .val", C.v6174 - 0.12, 0.16);
      count("v-fuel", 61.74, C.v6174 - 0.1, 1.0);
      tl.to("#pc-fuel", { opacity: 1, duration: 0.25 }, C.carburant + 1.0);
      tl.fromTo("#ul", { scaleX: 0 }, { scaleX: 1, duration: 0.35, ease: "expo.out" }, C.tout - 0.1);

      // ---------- 4. l'accise ----------
      tl.to("#l-fuel", { opacity: 0.32, duration: 0.3 }, C.accise - 0.25);
      tl.to("#ly-fuel .wave", { opacity: 0, duration: 0.25 }, C.accise - 0.1);
      glow("#gl-fuel", C.accise - 0.2, 0);
      glow("#gl-acc", C.accise - 0.2, 0.75);
      tl.fromTo("#ly-acc", { y: 320 }, { y: 0, duration: 1.0, ease: "power2.out" }, C.accise);
      blurIn("#l-acc", C.accise);
      blurIn("#l-acc .val", C.v4140 - 0.12, 0.16);
      count("v-acc", 41.4, C.v4140 - 0.1, 0.9);
      tl.to("#pc-acc", { opacity: 1, duration: 0.25 }, C.accise + 0.9);

      // ---------- 5. la TVA ----------
      tl.to("#l-acc", { opacity: 0.32, duration: 0.3 }, C.tva - 0.3);
      tl.to("#cam", { scale: 1.035, duration: 0.5, ease: "power2.inOut" }, C.meilleur - 0.1);
      tl.to("#ly-acc .wave", { opacity: 0, duration: 0.25 }, C.tva - 0.1);
      glow("#gl-acc", C.tva - 0.2, 0.25);
      glow("#gl-tva", C.tva - 0.2, 0.8);
      tl.fromTo("#ly-tva", { y: 530 }, { y: 0, duration: 0.9, ease: "power2.out" }, C.tva);
      blurIn("#l-tva", C.tva);
      tl.to("#pc-acc", { opacity: 0, duration: 0.15 }, C.aussi - 0.1);
      tl.fromTo("#taxtax", { opacity: 0, scale: 2, rotation: -12 }, { opacity: 1, scale: 1, rotation: -5, duration: 0.24, ease: "expo.out" }, C.aussi);
      tl.to("#l-acc", { opacity: 1, duration: 0.2 }, C.aussi);
      shake(C.aussi + 0.02, 12);
      flash(C.aussi + 0.02, 0.16);
      blurIn("#l-tva .val", C.v2064 - 0.12, 0.16);
      count("v-tva", 20.64, C.v2064 - 0.1, 0.9);
      tl.to("#pc-tva", { opacity: 1, duration: 0.25 }, C.v2064);

      // ---------- 6. bilan ----------
      tl.to("#cam", { scale: 1, duration: 0.01 }, C.resultat - 0.12);
      tl.to("#s-main", { scale: 1.35, opacity: 0, filter: "blur(16px)", duration: 0.32, ease: "power3.in" }, C.resultat - 0.3);
      glow("#gl-tva", C.resultat - 0.2, 0);
      glow("#gl-gold", C.resultat - 0.1, 1);
      tl.fromTo("#b-title span", { opacity: 0, filter: "blur(10px)", y: 30 }, { opacity: 1, filter: "blur(0px)", y: 0, duration: 0.16, stagger: 0.09, ease: "power3.out" }, C.resultat);
      tl.fromTo("#coin", { opacity: 0, scale: 0.4, rotation: -60 }, { opacity: 1, scale: 1, rotation: 0, duration: 0.5, ease: "back.out(1.7)" }, C.euro - 0.15);
      flash(C.resultat, 0.18);
      tl.to("#ch-l", { x: -70, rotation: -6, duration: 0.45, ease: "expo.out" }, C.deux);
      tl.to("#ch-r", { x: 70, rotation: 6, duration: 0.45, ease: "expo.out" }, C.deux);
      tl.to(["#tn-l", "#tn-r"], { opacity: 0.72, duration: 0.3 }, C.deux);
      tl.fromTo("#bl-l", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.deux + 0.05);
      tl.fromTo("#bl-r", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.deux + 0.12);
      shake(C.deux + 0.02, 10);
      tl.to("#ch-r", { x: 110, y: -20, scale: 1.08, duration: 0.4, ease: "expo.out" }, C.etat - 0.05);
      tl.to("#ch-l", { opacity: 0.45, duration: 0.3 }, C.etat - 0.05);
      tl.fromTo("#bl-r .v", { scale: 1 }, { keyframes: [{ scale: 1.15, duration: 0.08 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, C.etat);
      glow("#gl-acc", C.etat - 0.1, 0.8, 0.35);
      tl.to("#s-bilan", { x: -460, opacity: 0, filter: "blur(14px)", duration: 0.26, ease: "power3.in" }, C.abonne - 0.25);

      // ---------- 7. fin ----------
      glow("#gl-acc", C.abonne - 0.2, 0, 0.4);
      glow("#gl-gold", C.abonne - 0.2, 1, 0.4);
      tl.fromTo("#c-title div", { opacity: 0, x: 120, filter: "blur(12px)" }, { opacity: 1, x: 0, filter: "blur(0px)", duration: 0.32, stagger: 0.08, ease: "expo.out" }, C.abonne - 0.05);
      tl.fromTo("#c-btn span", { opacity: 0, scale: 0.5 }, { opacity: 1, scale: 1, duration: 0.42, ease: "back.out(2.4)" }, C.abonne + 0.3);
      tl.to("#c-btn span", { keyframes: [{ scale: 1.08, duration: 0.12 }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, Math.max(C.vraiment, C.abonne + 0.75));
      tl.fromTo("#c-ep", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3 }, C.abonne + 0.5);
      tl.fromTo("#c-src", { opacity: 0 }, { opacity: 1, duration: 0.4 }, C.abonne + 0.6);

      // ---------- sous-titres mot à mot ----------
      CAP.forEach((g) => {
        tl.fromTo("#" + g.id, { opacity: 0, y: 16 }, { opacity: 1, y: 0, duration: 0.1, ease: "power2.out" }, g.start);
        g.w.forEach((w) => {
          const el = document.getElementById(w.id);
          const em = el.classList.contains("em");
          tl.to(el, { color: em ? "#ffb21f" : "#f6f4ee", duration: 0.06 }, w.t);
          tl.to(el, { keyframes: [{ scale: 1.09, duration: 0.05 }, { scale: 1, duration: 0.22, ease: "power3.out" }] }, w.t);
        });
        tl.to("#" + g.id, { opacity: 0, duration: 0.08, ease: "power2.in" }, g.end - 0.08);
        tl.set("#" + g.id, { visibility: "hidden" }, g.end);
      });
      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
