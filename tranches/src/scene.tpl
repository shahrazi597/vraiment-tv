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
      #hk { position: absolute; left: 0; top: 0; }
      #h-stamp { top: 1050px; }

      /* ---------- l'escalier ---------- */
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 300px; height: 80px; }
      #infos { top: 392px; height: 80px; }
      #st { position: absolute; left: 0; top: 0; }

      /* ---------- l'exemple ---------- */
      #ex-t { position: absolute; left: 90px; right: 90px; top: 700px; display: flex; justify-content: space-between; align-items: baseline; opacity: 0; }
      #ex-t .k { font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; color: var(--muted); }
      #ex-t .v { font-size: 64px; font-weight: 900; letter-spacing: -.03em; color: var(--ink); white-space: nowrap; }
      #ebar { position: absolute; left: 90px; top: 790px; width: 900px; height: 96px; border-radius: 22px; border: 5px solid var(--cream);
        background: #111115; overflow: hidden; opacity: 0; }
      .seg { position: absolute; top: 0; bottom: 0; background: #2a2a32; }
      #sg1 { left: 0; width: 348px; border-right: 3px solid #0b0b0e; }
      #sg2 { left: 348px; width: 530px; border-right: 3px solid #0b0b0e; }
      #sg3 { left: 878px; width: 22px; }
      .tx { position: absolute; top: 905px; opacity: 0; white-space: nowrap; }
      .tx .v { font-size: 60px; font-weight: 900; letter-spacing: -.03em; line-height: 1; }
      .tx .s { font-size: 30px; font-weight: 700; color: var(--muted); margin-top: 6px; }
      #tx1 { left: 90px; width: 348px; text-align: center; } #tx1 .v { color: var(--cream); }
      #tx2 { left: 438px; width: 470px; text-align: center; } #tx2 .v { color: var(--amber); }
      #tx3 { right: 90px; text-align: right; top: 905px; } #tx3 .v { color: var(--red); }
      #tot { position: absolute; left: 0; right: 0; top: 1040px; text-align: center; font-size: 84px; font-weight: 900; letter-spacing: -.035em;
        text-transform: uppercase; opacity: 0; white-space: nowrap; }
      #tot .a { color: var(--amber); }

      /* ---------- bonus : 30 % contre 7 % ---------- */
      .col { position: absolute; top: 400px; width: 450px; text-align: center; opacity: 0; }
      #cl-a { left: 70px; } #cl-b { left: 560px; }
      .col .k { font-size: 36px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; color: var(--muted); white-space: nowrap; }
      .col .v { font-size: 160px; font-weight: 900; letter-spacing: -.05em; line-height: 1.02; white-space: nowrap; }
      #cl-a .v { color: var(--red); } #cl-b .v { color: var(--amber); }
      .col .chip { position: relative; display: inline-flex; margin-top: 18px; }
      #vs { position: absolute; left: 490px; width: 100px; top: 540px; text-align: center; font-size: 64px; font-weight: 900; color: var(--dim); opacity: 0; }
      #b-note { position: absolute; left: 120px; right: 120px; top: 900px; text-align: center; font-size: 40px; font-weight: 800; color: var(--cream); line-height: 1.25; opacity: 0; }

      /* ---------- chute : l'augmentation ---------- */
      #tw-title { top: 300px; font-size: 96px; }
      #tw-title .wsp { opacity: 0; }
      #coin { position: absolute; left: 0; top: 0; }
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
      </div>

      <div id="cam">
        <!-- 1. Accroche -->
        <div id="s-hook" class="clip" data-start="0" data-duration="%%HOOK_D%%" data-track-index="1" data-track-kind="graphics">
          <div id="h-t1" class="hl">Ta tranche<br />d'impôt te fait<br /><span class="r">perdre&nbsp;?</span></div>
          <svg id="hk" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <path id="hk-st" d="M200 1000 H340 V900 H480 V800 H620 V700 H760 V600 H880" fill="none" stroke="#ece6d6" stroke-width="10" stroke-linejoin="round" stroke-linecap="round" />
            <path d="M200 1000 H340 V900 H480 V800 H620 V700 H760 V600 H880 V1000 Z" fill="#ece6d6" opacity=".06" />
            <g id="hk-coin">
              <circle cx="270" cy="950" r="40" fill="#ffb21f" />
              <text x="270" y="966" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="46" fill="#0b0b0e">€</text>
            </g>
          </svg>
          <div id="h-stamp" class="stamp"><span>Jamais&nbsp;!</span></div>
        </div>

        <!-- 2. L'escalier, l'exemple, le bonus, la chute -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <svg id="st" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="stairs">
              <line x1="90" y1="1062" x2="990" y2="1062" stroke="#ece6d6" stroke-width="5" stroke-linecap="round" />
              <rect id="m1" x="110" y="1026" width="166" height="36" rx="8" fill="#2a2a32" />
              <rect id="m2" x="282" y="932" width="166" height="130" rx="8" fill="#2a2a32" />
              <rect id="m3" x="454" y="722" width="166" height="340" rx="8" fill="#2a2a32" />
              <rect id="m4" x="626" y="612" width="166" height="450" rx="8" fill="#1d1d23" stroke="#3a3a44" stroke-width="4" />
              <rect id="m5" x="798" y="572" width="166" height="490" rx="8" fill="#1d1d23" stroke="#3a3a44" stroke-width="4" />
              <g font-family="Inter Display" font-weight="900" font-size="66" text-anchor="middle" letter-spacing="-2">
                <text id="r1" x="193" y="1000" fill="#ece6d6">0 %</text>
                <text id="r2" x="365" y="906" fill="#ffb21f">11 %</text>
                <text id="r3" x="537" y="696" fill="#ff5236">30 %</text>
                <text id="r4" x="709" y="586" fill="#ece6d6" opacity=".75">41 %</text>
                <text id="r5" x="881" y="546" fill="#ece6d6" opacity=".75">45 %</text>
              </g>
              <g id="thr" font-family="Inter Display" font-weight="800" font-size="30" fill="#8e8c95">
                <text id="t1" x="110" y="1104">0 €</text>
                <text id="t2" x="282" y="1104">11 600 €</text>
                <text id="t3" x="454" y="1104">29 579 €</text>
                <text id="t4" x="626" y="1104">84 577 €</text>
                <text id="t5" x="798" y="1104">181 917 €</text>
              </g>
              <rect id="hl3" x="454" y="722" width="14" height="340" rx="4" fill="#ff5236" opacity="0" />
            </g>
          </svg>

          <div id="steps" class="row">
            <div id="st1" class="chip"><b>1</b>Jusqu'à 11&nbsp;600&nbsp;€ · 0&nbsp;%</div>
            <div id="st2" class="chip amb"><b>2</b>Jusqu'à 29&nbsp;579&nbsp;€ · 11&nbsp;%</div>
            <div id="st3" class="chip hot"><b>3</b>Au-dessus · 30&nbsp;%</div>
            <div id="st4" class="chip"><b>+</b>Les très gros revenus · 41 et 45&nbsp;%</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--amber)"></i>Chaque taux ne touche que SA marche</div>
          </div>

          <!-- l'exemple -->
          <div id="ex-t"><span class="k">Revenu imposable · 1 part</span><span class="v"><span id="ex-n">0</span>&nbsp;€</span></div>
          <div id="ebar" data-layout-allow-overflow><div id="sg1" class="seg"></div><div id="sg2" class="seg"></div><div id="sg3" class="seg"></div></div>
          <div id="tx1" class="tx"><div class="v"><span id="v1">0</span>&nbsp;€</div><div class="s">à 0&nbsp;%</div></div>
          <div id="tx2" class="tx"><div class="v"><span id="v2">0</span>&nbsp;€</div><div class="s">à 11&nbsp;%</div></div>
          <div id="tx3" class="tx"><div class="v"><span id="v3">0</span>&nbsp;€</div><div class="s">à 30&nbsp;%</div></div>
          <div id="tot">Total&nbsp;: <span class="a"><span id="v-tot">0</span>&nbsp;€</span></div>

          <!-- bonus -->
          <div id="cl-a" class="col"><div class="k">Ta tranche</div><div class="v">30&nbsp;%</div><span class="chip hot" style="opacity:1"><b>!</b>Taux marginal</span></div>
          <div id="vs">≠</div>
          <div id="cl-b" class="col"><div class="k">Ce que tu paies</div><div class="v"><span id="v-moy">0</span>&nbsp;%</div><span class="chip amb" style="opacity:1"><b>=</b>Taux moyen</span></div>
          <div id="b-note">2&nbsp;104&nbsp;€ sur 30&nbsp;000&nbsp;€ de revenus</div>

          <!-- chute -->
          <div id="tw-title" class="hl"><span class="wsp">Et</span> <span class="wsp">une</span><br /><span class="wsp a">augmentation&nbsp;?</span></div>
          <svg id="coin" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="c-one">
              <circle cx="540" cy="720" r="130" fill="#ffb21f" />
              <circle cx="540" cy="720" r="106" fill="none" stroke="#0b0b0e" stroke-width="6" opacity=".35" />
              <text x="540" y="762" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="120" letter-spacing="-4" fill="#0b0b0e">1 €</text>
            </g>
            <g id="c-70" opacity="0">
              <circle cx="360" cy="760" r="150" fill="#ffb21f" />
              <text x="360" y="790" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="96" letter-spacing="-4" fill="#0b0b0e">70 c</text>
              <text x="360" y="972" text-anchor="middle" font-family="Inter Display" font-weight="800" font-size="40" fill="#ffb21f">POUR TOI</text>
            </g>
            <g id="c-30" opacity="0">
              <circle cx="770" cy="760" r="92" fill="#ff5236" />
              <text x="770" y="782" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="64" letter-spacing="-3" fill="#0b0b0e">30 c</text>
              <text x="770" y="972" text-anchor="middle" font-family="Inter Display" font-weight="800" font-size="40" fill="#ff5236">D'IMPÔT</text>
            </g>
          </svg>
          <div id="tw-stamp" class="stamp"><span>Jamais moins&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 7 · Les tranches d'impôt</div>
          <div id="c-src">Barème 2026, 1 part, hors décote. Sources : service-public.gouv.fr · loi de finances 2026</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#7</span>
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

      // ================= 1. ACCROCHE =================
      D.glow("red", 0, 0.35, 0.01); D.glow("amber", 0, 0.25, 0.01);
      { const hops = [[270, 950], [410, 850], [550, 750], [690, 650], [820, 550]];
        hops.slice(1, 4).forEach(([x, y], i) => {
          const t = 0.25 + i * 0.38;
          tl.to("#hk-coin", { keyframes: [{ x: (x - 270) - 70 * 0.5, y: (y - 950) - 70, duration: 0.16, ease: "power2.out" },
                                          { x: x - 270, y: y - 950, duration: 0.14, ease: "power2.in" }] }, t);
        }); }
      tl.fromTo("#h-t1 .r", { scale: 1 }, { keyframes: [{ scale: 1.1, duration: 0.08 }, { scale: 1, duration: 0.3, ease: "expo.out" }] }, C.moins - 0.05);
      D.stamp("#h-stamp span", C.jamais1, -5);
      D.shake(C.jamais1 + 0.02, 10);
      D.flash(C.jamais1 + 0.02, 0.15);
      tl.fromTo("#h-stamp span", { scale: 1 }, { keyframes: [{ scale: 1.1, duration: 0.08 }, { scale: 1, duration: 0.3 }] }, C.jamais2);
      const T1 = C.alors;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 - 0.1, 0.16);
      tl.to("#hk", { opacity: 0, scale: 1.15, filter: "blur(10px)", transformOrigin: "540px 800px", duration: 0.35, ease: "power3.in" }, T1 - 0.1);
      D.glow("red", T1, 0, 0.4); D.glow("amber", T1, 0.15, 0.4); D.glow("cream", T1, 0.3, 0.4);

      // ================= 2. L'ESCALIER =================
      tl.fromTo("#stairs line", { opacity: 0, scaleX: 0, svgOrigin: "540 1062" }, { opacity: 1, scaleX: 1, duration: 0.4, ease: "power3.out" }, C.imagine);
      tl.fromTo(["#m1", "#m2", "#m3", "#m4", "#m5"], { scaleY: 0, transformOrigin: "50% 100%" }, { scaleY: 1, duration: 0.4, stagger: 0.09, ease: "back.out(1.6)" }, C.escalier - 0.25);
      tl.set(["#r1", "#r2", "#r3", "#r4", "#r5", "#thr text"], { opacity: 0 }, 0);
      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.12, 0.12); D.popIn("#st" + n, t, 0.6); };
      const lift = (sel, t) => tl.fromTo(sel, { y: 0 }, { keyframes: [{ y: -18, duration: 0.12, ease: "power2.out" }, { y: 0, duration: 0.35, ease: "bounce.out" }] }, t);
      // marche 1
      step(1, C.m1);
      tl.to("#m1", { fill: "#ece6d6", duration: 0.25 }, C.m1);
      lift("#m1", C.m1); D.blurIn("#t1", C.m1, 0.2); D.blurIn("#t2", C.n11a - 0.1, 0.2);
      D.blurIn("#r1", C.z0 - 0.1, 0.2);
      // marche 2
      step(2, C.m2);
      tl.to("#m1", { fill: "#55545c", duration: 0.3 }, C.m2);
      tl.to("#m2", { fill: "#ffb21f", duration: 0.25 }, C.m2);
      lift("#m2", C.m2); D.blurIn("#t3", C.n29a - 0.1, 0.2);
      D.blurIn("#r2", C.p11 - 0.1, 0.2);
      D.glow("amber", C.p11, 0.45, 0.4);
      // marche 3
      step(3, C.m3);
      tl.to("#m2", { fill: "#7a5a1c", duration: 0.3 }, C.m3);
      tl.to("#m3", { fill: "#ff5236", duration: 0.25 }, C.m3);
      lift("#m3", C.m3); D.blurIn("#t4", C.dessus1, 0.2);
      D.blurIn("#r3", C.p30 - 0.1, 0.2);
      D.glow("red", C.p30, 0.35, 0.4);
      // 41 et 45 %
      step(4, C.puis);
      D.blurIn("#r4", C.p41 - 0.1, 0.2); lift("#m4", C.p41 - 0.05);
      D.blurIn("#r5", C.p45 - 0.1, 0.2); lift("#m5", C.p45 - 0.05); D.blurIn("#t5", C.p45, 0.2);
      // le secret : chaque taux ne touche que sa marche
      D.blurOut("#st4", C.secret - 0.15, 0.12);
      tl.to(["#m1", "#m2", "#m3"], { fill: "#2a2a32", duration: 0.25 }, C.secret - 0.1);
      D.glow("red", C.secret, 0.1, 0.4); D.glow("amber", C.secret, 0.5, 0.4);
      D.popIn("#in1", C.chaque - 0.05, 0.5);
      tl.to("#m1", { fill: "#ece6d6", duration: 0.12 }, C.touche - 0.05);
      tl.to("#m2", { fill: "#ffb21f", duration: 0.12 }, C.euros1 - 0.05);
      tl.to("#m3", { fill: "#ff5236", duration: 0.12 }, C.sa - 0.05);
      tl.fromTo(["#m1", "#m2", "#m3"], { scaleX: 1, transformOrigin: "50% 100%" }, { keyframes: [{ scaleX: 0.9, duration: 0.1 }, { scaleX: 1, duration: 0.3, ease: "back.out(3)" }], stagger: 0.12 }, C.marche_sa - 0.1);

      // ================= L'EXEMPLE : 30 000 € =================
      D.blurOut("#in1", C.exemple - 0.2, 0.15);
      tl.to("#thr", { opacity: 0, duration: 0.2 }, C.exemple - 0.1);
      tl.to(["#m4", "#m5"], { opacity: 0.3, duration: 0.3 }, C.exemple - 0.1);
      tl.to(["#r1", "#r2", "#r3", "#r4", "#r5"], { opacity: 0, duration: 0.2 }, C.exemple - 0.1);
      tl.to(["#m1", "#m2", "#m3"], { fill: "#2a2a32", duration: 0.25 }, C.exemple - 0.1);
      tl.to("#stairs", { scale: 0.5, x: 0, y: -420, svgOrigin: "540 1062", duration: 0.5, ease: "power3.inOut" }, C.exemple - 0.1);
      tl.fromTo("#ex-t", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "expo.out" }, C.seul - 0.1);
      tl.fromTo("#ebar", { opacity: 0, filter: "blur(10px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.35 }, C.n30k - 0.15);
      countInt("ex-n", 0, 30000, C.n30k - 0.1, 1.0);
      // 11 600 premiers euros : zéro
      tl.to("#sg1", { backgroundColor: "#ece6d6", duration: 0.25 }, C.premiers - 0.15);
      tl.to("#m1", { fill: "#ece6d6", duration: 0.25 }, C.premiers - 0.15);
      D.blurIn("#tx1", C.zero - 0.12, 0.18);
      // les suivants : 1 978 €
      tl.to("#sg2", { backgroundColor: "#ffb21f", duration: 0.25 }, C.suivants - 0.1);
      tl.to("#m2", { fill: "#ffb21f", duration: 0.25 }, C.suivants - 0.1);
      D.glow("amber", C.suivants, 0.5, 0.4);
      D.blurIn("#tx2", C.n1978 - 0.15, 0.18);
      countInt("v2", 0, 1978, C.n1978 - 0.1, 1.0);
      // les 421 € du dessus : 126 €
      tl.to("#sg3", { backgroundColor: "#ff5236", duration: 0.2 }, C.n421 - 0.1);
      tl.to("#hl3", { opacity: 1, duration: 0.2 }, C.n421 - 0.1);
      tl.fromTo("#ebar", { x: 0 }, { keyframes: [{ x: 8, duration: 0.06 }, { x: -6, duration: 0.06 }, { x: 0, duration: 0.12 }] }, C.n421 - 0.05);
      D.glow("red", C.n421, 0.35, 0.4);
      D.blurIn("#tx3", C.n126 - 0.15, 0.18);
      countInt("v3", 0, 126, C.n126 - 0.1, 0.6);
      // total
      tl.fromTo("#tot", { opacity: 0, scale: 0.8 }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2)" }, C.total - 0.1);
      countInt("v-tot", 0, 2104, C.total, 0.9);

      // ================= BONUS : 30 % ≠ 7 % =================
      tl.to(["#st", "#ex-t", "#ebar", ".tx", "#tot"], { opacity: 0, filter: "blur(10px)", duration: 0.3 }, C.fou - 0.35);
      D.glow("amber", C.fou, 0.15, 0.4); D.glow("red", C.fou, 0.35, 0.4); D.glow("cream", C.fou, 0.1, 0.4);
      tl.fromTo("#cl-a", { opacity: 0, x: -60, filter: "blur(10px)" }, { opacity: 1, x: 0, filter: "blur(0px)", duration: 0.3, ease: "expo.out" }, C.tranche2 - 0.1);
      tl.to("#vs", { opacity: 1, duration: 0.2 }, C.mais2 - 0.1);
      tl.fromTo("#cl-b", { opacity: 0, x: 60, filter: "blur(10px)" }, { opacity: 1, x: 0, filter: "blur(0px)", duration: 0.3, ease: "expo.out" }, C.seulement2 - 0.15);
      D.glow("red", C.seulement2, 0.1, 0.4); D.glow("amber", C.seulement2, 0.5, 0.4);
      D.count("v-moy", 30, 7, C.seulement2 - 0.05, 0.55, 0);
      tl.fromTo("#cl-b .v", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, C.p7);
      D.flash(C.p7, 0.14, "#ffb21f");
      D.shake(C.p7 + 0.02, 9);
      D.blurIn("#b-note", C.seulement2 + 0.1, 0.2);

      // ================= CHUTE : l'augmentation =================
      tl.to(["#cl-a", "#cl-b", "#vs", "#b-note"], { opacity: 0, filter: "blur(10px)", duration: 0.25 }, C.et3 - 0.3);
      D.glow("red", C.et3 - 0.2, 0.05, 0.4); D.glow("amber", C.et3 - 0.2, 0.45, 0.4);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.08, ease: "power2.out" }, C.et3 - 0.1);
      tl.fromTo("#c-one", { opacity: 0, scale: 0.4, svgOrigin: "540 720" }, { opacity: 1, scale: 1, svgOrigin: "540 720", duration: 0.4, ease: "back.out(2.2)" }, C.euro3 - 0.15);
      tl.to("#c-one", { opacity: 0, scale: 0.7, svgOrigin: "540 720", duration: 0.18, ease: "power2.in" }, C.laisse - 0.15);
      tl.fromTo("#c-70", { opacity: 0, x: 180 }, { opacity: 1, x: 0, duration: 0.4, ease: "back.out(1.8)" }, C.laisse);
      tl.fromTo("#c-30", { opacity: 0, x: -230 }, { opacity: 1, x: 0, duration: 0.4, ease: "back.out(1.8)" }, C.laisse);
      tl.fromTo("#c-70", { scale: 1 }, { keyframes: [{ scale: 1.08, duration: 0.09 }, { scale: 1, duration: 0.3 }], svgOrigin: "360 760" }, C.c70);
      D.stamp("#tw-stamp span", C.jamais3, -5);
      D.shake(C.jamais3 + 0.02, 11);
      D.glow("red", C.jamais3, 0.4, 0.3);
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
