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
      #h-t1 { top: 300px; font-size: 104px; }
      .hc { position: absolute; left: 140px; width: 800px; height: 200px; border-radius: 32px; background: var(--panel); border: 4px solid var(--line);
        display: flex; flex-direction: column; justify-content: center; padding: 0 48px; }
      .hc .k { font-size: 34px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); white-space: nowrap; }
      .hc .v { font-size: 112px; font-weight: 900; letter-spacing: -.045em; line-height: 1; white-space: nowrap; }
      #hc-a { top: 560px; border-color: var(--red); } #hc-a .v { color: var(--red); }
      #hc-b { top: 800px; border-color: var(--amber); opacity: 0; } #hc-b .v { color: var(--amber); }
      #h-gap { position: absolute; left: 0; right: 0; top: 1040px; text-align: center; font-size: 60px; font-weight: 900; color: var(--ink); opacity: 0; white-space: nowrap; }
      #h-gap .r { color: var(--red); }

      /* ---------- la barre ---------- */
      #ptag { position: absolute; left: 90px; top: 300px; width: 330px; height: 104px; border-radius: 28px; background: var(--panel);
        border: 3px solid var(--line); display: flex; align-items: center; justify-content: center; opacity: 0;
        font-size: 64px; font-weight: 900; letter-spacing: -.04em; color: var(--ink); white-space: nowrap; }
      #bar { position: absolute; left: 90px; top: 420px; width: 330px; height: 710px; border-radius: 34px; border: 5px solid var(--cream);
        background: #111115; overflow: hidden; opacity: 0; }
      .sl { position: absolute; left: 0; right: 0; background: #2a2a32; border-bottom: 2px solid #0b0b0e; }
      #sl-pat { top: 0; height: 43px; }
      #sl-sal { top: 43px; height: 147px; }
      #sl-net { top: 190px; height: 520px; border-bottom: 0; }
      .sl .pct { position: absolute; left: 0; right: 0; top: 50%; margin-top: -34px; text-align: center; font-size: 60px; font-weight: 900;
        letter-spacing: -.03em; color: rgba(11,11,14,.85); opacity: 0; }
      #brk { position: absolute; left: 0; top: 0; }

      .label { position: absolute; left: 470px; width: 580px; opacity: 0; }
      .label .name { display: flex; align-items: center; gap: 14px; font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; white-space: nowrap; }
      .label .name i { display: block; width: 22px; height: 22px; border-radius: 6px; }
      .label .sub { font-size: 30px; font-weight: 600; color: var(--muted); margin-top: 4px; white-space: nowrap; }
      .label .val { font-size: 84px; font-weight: 900; letter-spacing: -.045em; line-height: 1.04; margin-top: 2px; white-space: nowrap; opacity: 0; }
      #l-brut { top: 430px; } #l-brut .val { color: var(--ink); }
      #l-pat { top: 430px; } #l-pat .val { color: var(--red); }
      #l-sal { top: 640px; } #l-sal .val { color: var(--cream); }
      #l-red { top: 640px; } #l-red .val { color: var(--cold); }
      #l-net { top: 960px; } #l-net .val { color: var(--amber); }
      .chips { position: absolute; left: 470px; width: 580px; display: flex; flex-direction: column; align-items: flex-start; gap: 12px; }
      .chips .chip { position: relative; font-size: 30px; padding: 10px 20px; }
      .chip i { display: block; width: 20px; height: 20px; border-radius: 50%; }
      #ch-brut { top: 580px; }
      #ch-sal { top: 790px; }

      /* ---------- bonus : l'augmentation ---------- */
      #b-num { position: absolute; left: 0; right: 0; top: 330px; text-align: center; font-size: 150px; font-weight: 900; letter-spacing: -.05em;
        color: var(--cream); line-height: 1; opacity: 0; white-space: nowrap; }
      #b-sub { position: absolute; left: 0; right: 0; top: 490px; text-align: center; font-size: 40px; font-weight: 800; color: var(--muted); opacity: 0; }
      .bc { position: absolute; top: 600px; width: 430px; height: 330px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        text-align: center; opacity: 0; }
      .bc .k { margin-top: 42px; font-size: 36px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); }
      .bc .v { font-size: 112px; font-weight: 900; letter-spacing: -.05em; line-height: 1.05; white-space: nowrap; }
      .bc .s { font-size: 32px; font-weight: 700; color: var(--muted); }
      #bc-a { left: 90px; border-color: var(--amber); } #bc-a .v { color: var(--amber); }
      #bc-b { left: 560px; border-color: var(--red); } #bc-b .v { color: var(--red); }
      #b-stamp { top: 990px; }

      /* ---------- chute : la réduction fond ---------- */
      #ch-t { position: absolute; left: 0; right: 0; top: 330px; text-align: center; font-size: 40px; font-weight: 800; letter-spacing: .05em;
        text-transform: uppercase; color: var(--muted); opacity: 0; }
      #curve { position: absolute; left: 0; top: 0; opacity: 0; }
      #tw-stamp { top: 1030px; }
      #tw-stamp span { font-size: 56px; }
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
          <div id="h-t1" class="hl">Un salarié<br />au <span class="a">SMIC</span></div>
          <div id="hc-a" class="hc"><div class="k">Coûte à son patron</div><div class="v"><span id="h-n1">1&nbsp;988</span>&nbsp;€</div></div>
          <div id="hc-b" class="hc"><div class="k">Touche sur son compte</div><div class="v"><span id="h-n2">0</span>&nbsp;€</div></div>
          <div id="h-gap">Il manque <span class="r">532&nbsp;€</span>&nbsp;!</div>
        </div>

        <!-- 2. Où passe l'argent -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="ptag"><span id="p-num">1&nbsp;988</span>&nbsp;€</div>
          <div id="bar" data-layout-allow-overflow>
            <div id="sl-pat" class="sl"></div>
            <div id="sl-sal" class="sl"></div>
            <div id="sl-net" class="sl"><div id="pc-net" class="pct">73&nbsp;%</div></div>
          </div>
          <svg id="brk" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <path id="brk-p" d="M440 470 H452 V1125 H440" fill="none" stroke="#f6f4ee" stroke-width="5" stroke-linecap="round" stroke-linejoin="round" opacity="0" />
          </svg>

          <div id="l-brut" class="label"><div class="name"><i style="background:var(--ink)"></i>Salaire brut</div><div class="val"><span id="v-brut">0</span>&nbsp;€</div></div>
          <div id="ch-brut" class="chips"><span id="cb1" class="chip"><i style="background:var(--ink)"></i>Le chiffre du contrat</span></div>
          <div id="l-sal" class="label"><div class="name"><i style="background:var(--cream)"></i>Cotisations salariales</div><div class="val">−<span id="v-sal">0</span>&nbsp;€</div></div>
          <div id="ch-sal" class="chips">
            <span id="cs1" class="chip"><i style="background:var(--cream)"></i>180&nbsp;€ de CSG et CRDS</span>
            <span id="cs2" class="chip"><i style="background:var(--cream)"></i>Le reste : surtout ta retraite</span>
          </div>
          <div id="l-net" class="label"><div class="name"><i style="background:var(--amber)"></i>Ton salaire net</div><div class="val"><span id="v-net">0</span>&nbsp;€</div></div>
          <div id="l-pat" class="label"><div class="name"><i style="background:var(--red)"></i>Cotisations patronales</div><div class="val">+<span id="v-pat">0</span>&nbsp;€</div></div>
          <div id="l-red" class="label"><div class="name"><i style="background:var(--cold)"></i>Réduction de l'État</div><div class="sub">au niveau du SMIC, chaque mois</div><div class="val">−<span id="v-red">0</span>&nbsp;€</div></div>

          <!-- bonus -->
          <div id="b-num">+100&nbsp;€</div>
          <div id="b-sub">d'augmentation brute</div>
          <div id="bc-a" class="bc"><div class="k">Toi</div><div class="v">+<span id="v-79">0</span>&nbsp;€</div><div class="s">en net</div></div>
          <div id="bc-b" class="bc"><div class="k">Ton patron</div><div class="v">+<span id="v-197">0</span>&nbsp;€</div><div class="s">de coût en plus</div></div>
          <div id="b-stamp" class="stamp"><span>2,5 fois plus&nbsp;!</span></div>

          <!-- chute -->
          <div id="ch-t">La réduction, selon ton salaire</div>
          <svg id="curve" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <line x1="130" y1="900" x2="960" y2="900" stroke="#ece6d6" stroke-width="5" stroke-linecap="round" />
            <line x1="130" y1="420" x2="130" y2="900" stroke="#2a2a32" stroke-width="4" />
            <path id="cv-area" d="M150 450 C300 560 420 700 560 780 C680 845 820 880 930 892 L930 900 L150 900 Z" fill="#4cc4ff" opacity=".12" />
            <path id="cv" d="M150 450 C300 560 420 700 560 780 C680 845 820 880 930 892" fill="none" stroke="#4cc4ff" stroke-width="10" stroke-linecap="round" />
            <circle id="cv-dot" cx="150" cy="450" r="18" fill="#4cc4ff" />
            <g font-family="Inter Display" font-weight="900" fill="#4cc4ff">
              <text id="cv-a" x="210" y="406" font-size="64" letter-spacing="-2" text-anchor="middle">700 €</text>
            </g>
            <g font-family="Inter Display" font-weight="800" font-size="30" fill="#8e8c95">
              <text id="cv-x1" x="150" y="948" text-anchor="middle">SMIC</text>
              <text id="cv-x2" x="930" y="948" text-anchor="middle">3 SMIC</text>
              <text id="cv-x3" x="540" y="948" text-anchor="middle">ton salaire →</text>
            </g>
          </svg>
          <div id="tw-stamp" class="stamp"><span>La trappe à bas salaires</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Combien ça</div><div>coûte</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 5 · Un salarié au SMIC</div>
          <div id="c-src">SMIC 2026, temps plein, petite entreprise. Source : simulateur de l'Urssaf (nov. 2026)</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMBIEN ÇA COÛTE VRAIMENT&nbsp;?</span><span class="pill num">#5</span>
      </div>

      <div id="fx" class="clip" data-start="0" data-duration="%%END%%" data-track-index="7" data-track-kind="graphics">
        <div id="flash"></div>
      </div>
    </div>

    <script>
      const C = %%CUES%%;
      const CAP = %%CAPDATA%%;
      DA.fitCaptions(CAP);
      const tl = gsap.timeline({ paused: true });
      const D = DA(tl);
      D.drift(C.end);
      const sp = (v) => Math.round(v).toLocaleString("fr-FR").replace(/ | |,/g, " ");
      const countInt = (id, a, b, at, d) => { const o = { v: a }, el = document.getElementById(id);
        tl.to(o, { v: b, duration: d, ease: "power2.out", onUpdate: () => (el.textContent = sp(o.v)) }, at); };
      const pulse = (sel, at, s = 1.08) => tl.fromTo(sel, { scale: 1 }, { keyframes: [{ scale: s, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, at);

      // ================= 1. ACCROCHE =================
      D.glow("red", 0, 0.4, 0.01); D.glow("amber", 0, 0.2, 0.01);
      pulse("#hc-a", C.n988 - 0.05, 1.05);
      D.glow("amber", C.mais, 0.45, 0.4); D.glow("red", C.mais, 0.2, 0.4);
      tl.fromTo("#hc-b", { opacity: 0, y: 50, filter: "blur(10px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.3, ease: "expo.out" }, C.touche - 0.1);
      countInt("h-n2", 0, 1456, C.seulement - 0.05, 0.9);
      D.shake(C.n456, 9);
      D.flash(C.n456, 0.14, "#ffb21f");
      tl.fromTo("#h-gap", { opacity: 0, scale: 0.7 }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2.2)" }, C.n532 - 0.1);
      // les cartes se rangent dans la barre
      const T1 = C.dabord;
      D.blurOut(["#h-t1", "#h-gap"], T1 - 0.3, 0.15);
      tl.to(["#hc-a", "#hc-b"], { x: -300, y: 120, scale: 0.4, opacity: 0, duration: 0.4, ease: "power3.inOut" }, T1 - 0.3);
      D.glow("red", T1, 0.1, 0.4); D.glow("amber", T1, 0.15, 0.4); D.glow("cream", T1, 0.4, 0.4);

      // ================= 2. OÙ PASSE L'ARGENT =================
      tl.fromTo("#ptag", { opacity: 0, y: 60, scale: 0.8 }, { opacity: 1, y: 0, scale: 1, duration: 0.4, ease: "expo.out" }, T1 - 0.05);
      tl.fromTo("#bar", { opacity: 0, y: 140, filter: "blur(10px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, T1 - 0.1);
      tl.fromTo("#bar .sl", { scaleX: 0, transformOrigin: "0% 50%" }, { scaleX: 1, duration: 0.3, stagger: 0.06, ease: "power3.out" }, T1 + 0.2);
      // le brut
      tl.to("#brk-p", { opacity: 1, duration: 0.25 }, C.brut1 - 0.1);
      tl.to(["#sl-sal", "#sl-net"], { backgroundColor: "#55545c", duration: 0.25 }, C.brut1 - 0.1);
      D.blurIn("#l-brut", C.salaire1 - 0.1);
      D.blurIn("#l-brut .val", C.n867 - 0.12, 0.16);
      countInt("v-brut", 0, 1867, C.n867 - 0.1, 1.0);
      D.popIn("#cb1", C.contrat - 0.2, 0.5);
      // les cotisations salariales
      D.blurOut("#cb1", C.retire - 0.3, 0.15);
      tl.to("#sl-sal", { backgroundColor: "#ece6d6", duration: 0.25 }, C.retire - 0.1);
      tl.fromTo("#sl-sal", { x: 0 }, { keyframes: [{ x: 26, duration: 0.15 }, { x: 0, duration: 0.3, ease: "expo.out" }] }, C.retire - 0.1);
      D.blurIn("#l-sal", C.retire - 0.1);
      D.blurIn("#l-sal .val", C.n411 - 0.12, 0.16);
      countInt("v-sal", 0, 411, C.n411 - 0.1, 0.9);
      D.popIn("#cs1", C.n180 - 0.1, 0.5);
      D.glow("cream", C.secu, 0.55, 0.4);
      D.popIn("#cs2", C.reste - 0.1, 0.5);
      // le net
      tl.to("#sl-net", { backgroundColor: "#ffb21f", duration: 0.3 }, C.resultat - 0.1);
      D.glow("amber", C.resultat, 0.5, 0.4); D.glow("cream", C.resultat, 0.2, 0.4);
      D.blurIn("#l-net", C.resultat - 0.1);
      D.blurIn("#l-net .val", C.n456b - 0.15, 0.16);
      countInt("v-net", 0, 1456, C.n456b - 0.1, 0.9);
      tl.to("#pc-net", { opacity: 1, duration: 0.25 }, C.net + 0.2);
      pulse("#l-net .val", C.net, 1.08);
      // côté patron
      tl.to("#brk-p", { opacity: 0, duration: 0.2 }, C.cote - 0.2);
      tl.to(["#l-brut", "#l-sal", "#ch-sal"], { opacity: 0, filter: "blur(8px)", duration: 0.25 }, C.cote - 0.25);
      tl.to("#sl-pat", { backgroundColor: "#ff5236", duration: 0.25 }, C.ajoute - 0.1);
      tl.fromTo("#sl-pat", { x: 0 }, { keyframes: [{ x: 26, duration: 0.15 }, { x: 0, duration: 0.3, ease: "expo.out" }] }, C.ajoute - 0.1);
      D.glow("red", C.ajoute, 0.4, 0.4); D.glow("amber", C.ajoute, 0.15, 0.4);
      D.blurIn("#l-pat", C.cote - 0.05);
      D.blurIn("#l-pat .val", C.n121 - 0.12, 0.16);
      countInt("v-pat", 0, 121, C.n121 - 0.1, 0.7);
      pulse("#ptag", C.n121 + 0.5, 1.1);
      pulse("#l-pat .val", C.seulement2, 1.1);
      // la réduction de l'État
      D.blurIn("#l-red", C.niveau - 0.1);
      D.blurIn("#l-red .val", C.n700 - 0.12, 0.16);
      countInt("v-red", 0, 700, C.n700 - 0.1, 1.0);
      D.glow("cold", C.n700, 0.45, 0.4); D.glow("red", C.n700, 0.15, 0.4);

      // ================= BONUS : +100 € brut =================
      tl.to(["#ptag", "#bar", ".label", "#ch-brut", "#ch-sal"], { opacity: 0, filter: "blur(10px)", duration: 0.3 }, C.fou - 0.3);
      D.glow("cold", C.fou, 0, 0.4); D.glow("amber", C.fou, 0.25, 0.4); D.glow("cream", C.fou, 0.3, 0.4);
      tl.fromTo("#b-num", { opacity: 0, scale: 0.7, filter: "blur(10px)" }, { opacity: 1, scale: 1, filter: "blur(0px)", duration: 0.35, ease: "back.out(2)" }, C.n100 - 0.15);
      D.blurIn("#b-sub", C.brut3 - 0.1);
      tl.fromTo("#bc-a", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.toi - 0.1);
      countInt("v-79", 0, 79, C.n79 - 0.1, 0.7);
      D.glow("amber", C.n79, 0.5, 0.4);
      tl.fromTo("#bc-b", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.lui3 - 0.1);
      countInt("v-197", 0, 197, C.n197 - 0.1, 0.8);
      D.glow("red", C.n197, 0.45, 0.4); D.glow("amber", C.n197, 0.15, 0.4);
      pulse("#bc-b", C.n197 + 0.35, 1.06);
      D.stamp("#b-stamp span", C.n197 + 0.4, -5);
      D.shake(C.n197 + 0.42, 11);
      D.flash(C.n197 + 0.42, 0.15);

      // ================= CHUTE : la réduction fond =================
      tl.to(["#b-num", "#b-sub", "#bc-a", "#bc-b", "#b-stamp span"], { opacity: 0, filter: "blur(10px)", duration: 0.25 }, C.plus_monte - 0.15);
      D.glow("red", C.plus_monte, 0, 0.4); D.glow("amber", C.plus_monte, 0, 0.4); D.glow("cold", C.plus_monte, 0.4, 0.4);
      D.blurIn("#ch-t", C.plus_monte - 0.1);
      tl.to("#curve", { opacity: 1, duration: 0.25 }, C.plus_monte - 0.1);
      { const cv = document.getElementById("cv"), L = cv.getTotalLength(); cv.style.strokeDasharray = L; cv.style.strokeDashoffset = L;
        tl.to(cv, { strokeDashoffset: 0, duration: C.fond - C.plus_monte + 0.3, ease: "power1.inOut" }, C.plus_monte);
        const o = { p: 0 }, dot = document.getElementById("cv-dot");
        tl.to(o, { p: 1, duration: C.fond - C.plus_monte + 0.3, ease: "power1.inOut", onUpdate: () => { const q = cv.getPointAtLength(o.p * L); dot.setAttribute("cx", q.x); dot.setAttribute("cy", q.y); const lb = document.getElementById("cv-a"); lb.setAttribute("x", Math.min(860, Math.max(210, q.x))); lb.setAttribute("y", q.y - 44); } }, C.plus_monte); }
      tl.fromTo("#cv-area", { opacity: 0 }, { opacity: 0.12, duration: 0.6 }, C.reduction);
      D.count("cv-a", 700, 110, C.reduction - 0.1, C.fond - C.reduction + 0.4, 0, " €");
      D.stamp("#tw-stamp span", C.trappe - 0.05, -4);
      D.shake(C.trappe, 10);
      D.glow("red", C.trappe, 0.4, 0.3);
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
