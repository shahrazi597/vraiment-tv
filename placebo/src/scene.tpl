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
      #pillsvg { position: absolute; left: 0; top: 0; }
      #h-stamp { top: 1020px; }
      #h-stamp span { font-size: 72px; }

      /* ---------- étapes ---------- */
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 300px; height: 80px; }
      #infos { top: 392px; height: 80px; }

      /* étape 1 */
      #mg { position: absolute; left: 560px; top: 560px; width: 430px; height: 230px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        text-align: center; opacity: 0; }
      #mg .k { margin-top: 36px; font-size: 32px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; color: var(--muted); }
      #mg .v { font-size: 110px; font-weight: 900; letter-spacing: -.05em; color: var(--cream); line-height: 1.05; white-space: nowrap; }
      #bubble { position: absolute; left: 140px; top: 860px; width: 800px; height: 170px; border-radius: 40px; background: var(--amber); color: var(--ground);
        display: flex; align-items: center; justify-content: center; font-size: 58px; font-weight: 900; letter-spacing: -.02em; opacity: 0; white-space: nowrap; }
      #bubble::after { content: ""; position: absolute; left: 160px; bottom: -34px; border: 22px solid transparent; border-top: 22px solid var(--amber); }
      #bubble .who { position: absolute; top: -52px; left: 0; font-size: 32px; font-weight: 800; color: var(--muted); letter-spacing: .05em; text-transform: uppercase; }

      /* étape 2 */
      .rx { position: absolute; left: 90px; width: 620px; height: 140px; border-radius: 30px; background: var(--panel); border: 4px solid var(--line);
        display: flex; align-items: center; gap: 26px; padding: 0 36px; opacity: 0; }
      .rx .ar { font-size: 84px; font-weight: 900; line-height: 1; width: 56px; text-align: center; }
      .rx .t { font-size: 40px; font-weight: 900; text-transform: uppercase; letter-spacing: -.02em; white-space: nowrap; }
      #rx1 { top: 540px; border-color: var(--amber); } #rx1 .ar { color: var(--amber); }
      #rx2 { top: 710px; border-color: var(--amber); } #rx2 .ar { color: var(--amber); }
      #rx3 { top: 880px; border-color: var(--cold); } #rx3 .ar { color: var(--cold); }
      #gauge { position: absolute; left: 740px; top: 520px; width: 250px; height: 520px; border-radius: 34px; border: 5px solid var(--cream); background: #111115;
        overflow: hidden; opacity: 0; }
      #g-fill { position: absolute; left: 0; right: 0; bottom: 0; height: 80%; background: var(--red); }
      #g-lbl { position: absolute; left: 740px; width: 250px; top: 1050px; text-align: center; font-size: 34px; font-weight: 800; letter-spacing: .05em; color: var(--muted); opacity: 0; }

      /* étape 3 et bonus : barres en % */
      .pb { position: absolute; left: 90px; width: 900px; opacity: 0; }
      .pb .k { display: flex; justify-content: space-between; align-items: flex-end; font-size: 38px; font-weight: 900; text-transform: uppercase; white-space: nowrap; }
      .pb .k .v { font-size: 96px; letter-spacing: -.05em; line-height: 1; }
      .pb .tr { margin-top: 14px; height: 70px; border-radius: 20px; background: #1d1d23; overflow: hidden; }
      .pb .fl { height: 100%; border-radius: 20px; }
      #pb1 { top: 560px; } #pb1 .v { color: var(--amber); } #pb1 .fl { width: 85%; background: var(--amber); }
      #pb2 { top: 800px; } #pb2 .v { color: var(--cream); } #pb2 .fl { width: 61%; background: var(--cream); }
      #pb3 { top: 600px; } #pb3 .v { color: var(--amber); } #pb3 .fl { width: 59%; background: var(--amber); }
      #pb4 { top: 840px; } #pb4 .v { color: var(--muted); } #pb4 .fl { width: 35%; background: #5d5b64; }
      .pb .s { font-size: 30px; font-weight: 700; color: var(--muted); margin-top: 4px; white-space: nowrap; }
      #b-t { position: absolute; left: 0; right: 0; top: 480px; text-align: center; font-size: 60px; font-weight: 900; text-transform: uppercase; letter-spacing: -.02em; opacity: 0; white-space: nowrap; }
      #b-t .a { color: var(--amber); }

      /* nocebo */
      #n-t { top: 480px; font-size: 120px; }
      #warns { position: absolute; left: 0; right: 0; top: 680px; display: flex; justify-content: center; gap: 30px; }
      .wn { width: 190px; height: 190px; border-radius: 40px; border: 7px solid #5d5b64; display: flex; align-items: center; justify-content: center;
        font-size: 110px; font-weight: 900; color: #75737c; opacity: 0; background: #111115; }
      .wn.on { border-color: var(--red); color: var(--red); }
      #n-sub { position: absolute; left: 0; right: 0; top: 895px; text-align: center; font-size: 38px; font-weight: 800; color: var(--muted); opacity: 0; white-space: nowrap; line-height: 1.3; }
      #n-stamp { top: 1010px; }

      /* chute */
      .ok { position: absolute; left: 90px; width: 900px; height: 190px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        display: flex; align-items: center; gap: 34px; padding: 0 44px; opacity: 0; }
      .ok .ic { font-size: 100px; font-weight: 900; width: 80px; text-align: center; line-height: 1; }
      .ok .t { font-size: 48px; font-weight: 900; text-transform: uppercase; letter-spacing: -.02em; line-height: 1.05; white-space: nowrap; }
      #at-t { top: 400px; font-size: 100px; opacity: 0; }
      #ok1 { top: 580px; border-color: var(--red); } #ok1 .ic { color: var(--red); }
      #ok2 { top: 810px; border-color: var(--cold); } #ok2 .ic { color: var(--cold); }
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
          <div id="h-t1" class="hl">Une pilule<br />de <span class="a">sucre</span><br />peut soulager</div>
          <svg id="pillsvg" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g transform="translate(0 110) rotate(-24 540 800)"><g id="pill">
              <path d="M540 720 H420 a80 80 0 0 0 0 160 H540 Z" fill="#ffb21f" />
              <path d="M540 720 H660 a80 80 0 0 1 0 160 H540 Z" fill="#ece6d6" />
              <rect x="340" y="720" width="400" height="160" rx="80" fill="none" stroke="#0b0b0e" stroke-width="6" />
              <rect x="380" y="742" width="120" height="22" rx="11" fill="#fff" opacity=".35" />
            </g></g>
            <g id="sparks" transform="translate(0 110)" stroke="#ffb21f" stroke-width="10" stroke-linecap="round" opacity="0">
              <line x1="300" y1="620" x2="260" y2="580" /><line x1="780" y1="620" x2="820" y2="580" /><line x1="540" y1="590" x2="540" y2="540" />
              <line x1="290" y1="960" x2="250" y2="1000" /><line x1="790" y1="960" x2="830" y2="1000" />
            </g>
          </svg>
          <div id="h-stamp" class="stamp"><span>Même en le sachant&nbsp;!</span></div>
        </div>

        <!-- 2. Les étapes -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="steps" class="row">
            <div id="st1" class="chip amb"><b>1</b>TU AVALES</div>
            <div id="st2" class="chip"><b>2</b>TON CERVEAU RÉAGIT</div>
            <div id="st3" class="chip cold"><b>3</b>LE CONTEXTE</div>
          </div>
          <div id="infos" class="row">
            <div id="in3" class="chip"><i style="background:var(--amber)"></i>Douleur : décharges électriques légères (JAMA, 2008)</div>
            <div id="in4" class="chip"><i style="background:var(--amber)"></i>Harvard, 2010 · 80 patients, 3 semaines</div>
            <div id="in5" class="chip"><i style="background:var(--red)"></i>Essais des vaccins Covid (JAMA Netw. Open, 2022)</div>
          </div>

          <!-- étape 1 -->
          <svg id="pill2svg" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true" style="position:absolute;left:0;top:0">
            <g id="pill2" opacity="0" transform="rotate(-24 300 675)">
              <path d="M300 625 H230 a50 50 0 0 0 0 100 H300 Z" fill="#ffb21f" />
              <path d="M300 625 H370 a50 50 0 0 1 0 100 H300 Z" fill="#ece6d6" />
              <rect x="180" y="625" width="240" height="100" rx="50" fill="none" stroke="#0b0b0e" stroke-width="5" />
            </g>
          </svg>
          <div id="mg"><div class="k">Médicament</div><div class="v">0&nbsp;mg</div></div>
          <div id="bubble"><span class="who">Ton cerveau</span>«&nbsp;Je vais aller mieux&nbsp;»</div>

          <!-- étape 2 -->
          <div id="rx1" class="rx"><div class="ar">↑</div><div class="t">Endorphines</div></div>
          <div id="rx2" class="rx"><div class="ar">↑</div><div class="t">Dopamine</div></div>
          <div id="rx3" class="rx"><div class="ar">↓</div><div class="t">Zones de la douleur</div></div>
          <div id="gauge"><div id="g-fill"></div></div>
          <div id="g-lbl">DOULEUR</div>

          <!-- étape 3 -->
          <div id="pb1" class="pb"><div class="k"><span>Pilule «&nbsp;chère&nbsp;»</span><span class="v"><span id="v-85">0</span>&nbsp;%</span></div><div class="tr"><div class="fl"></div></div><div class="s">soulagés</div></div>
          <div id="pb2" class="pb"><div class="k"><span>Même pilule «&nbsp;soldée&nbsp;»</span><span class="v"><span id="v-61">0</span>&nbsp;%</span></div><div class="tr"><div class="fl"></div></div><div class="s">soulagés</div></div>

          <!-- bonus -->
          <div id="b-t">Ils <span class="a">savaient</span> : placebo</div>
          <div id="pb3" class="pb"><div class="k"><span>Avec le placebo</span><span class="v"><span id="v-59">0</span>&nbsp;%</span></div><div class="tr"><div class="fl"></div></div><div class="s">soulagés</div></div>
          <div id="pb4" class="pb"><div class="k"><span>Sans rien prendre</span><span class="v"><span id="v-35">0</span>&nbsp;%</span></div><div class="tr"><div class="fl"></div></div><div class="s">soulagés</div></div>

          <!-- nocebo -->
          <div id="n-t" class="hl"><span class="r">Effet nocebo</span></div>
          <div id="warns"><div class="wn">!</div><div class="wn">!</div><div class="wn">!</div><div class="wn">!</div></div>
          <div id="n-sub">effets secondaires généraux après la 1<sup>re</sup> dose</div>
          <div id="n-stamp" class="stamp"><span>3 sur 4&nbsp;: l'attente&nbsp;!</span></div>

          <!-- chute -->
          <div id="at-t" class="hl"><span class="r">Attention</span></div>
          <div id="ok1" class="ok"><div class="ic">✕</div><div class="t">Ne guérit pas<br />une maladie</div></div>
          <div id="ok2" class="ok"><div class="ic">✓</div><div class="t">Agit sur ce que<br />tu ressens</div></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 12 · L'effet placebo</div>
          <div id="c-src">Sources : Kaptchuk et al., PLoS ONE (2010) ; Waber et al., JAMA (2008) ; Santé.fr</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#12</span>
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
      const pulse = (sel, at, s = 1.08) => tl.fromTo(sel, { scale: 1 }, { keyframes: [{ scale: s, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, at);
      const out = (sel, at, d = 0.25) => tl.to(sel, { opacity: 0, filter: "blur(10px)", duration: d }, at);
      const bar = (id, pct, at, show = null) => {
        tl.fromTo(id, { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 0.3, ease: "expo.out" }, show === null ? at - 0.3 : show);
        tl.fromTo(id + " .fl", { scaleX: 0, transformOrigin: "0% 50%" }, { scaleX: 1, duration: 0.9, ease: "power2.out", immediateRender: true }, at - 0.1);
        D.count("v-" + pct, 0, pct, at - 0.1, 0.9, 0);
      };

      // ================= 1. ACCROCHE =================
      D.glow("amber", 0, 0.4, 0.01);
      tl.fromTo("#pill", { y: 0 }, { y: -14, duration: 1.4, ease: "sine.inOut", yoyo: true, repeat: 1 }, 0);
      pulse("#h-t1 .a", C.pilule + 0.3, 1.1);
      tl.to("#sparks", { opacity: 1, duration: 0.2 }, C.soulager);
      tl.fromTo("#sparks line", { scale: 0.4, transformOrigin: "50% 50%" }, { scale: 1, duration: 0.3, stagger: 0.04, ease: "back.out(3)" }, C.soulager);
      D.glow("amber", C.soulager, 0.6, 0.3);
      tl.to("#pillsvg", { opacity: 0.4, duration: 0.25 }, C.sais - 0.15);
      D.stamp("#h-stamp span", C.sais - 0.05, -5);
      D.shake(C.sais, 10);
      D.flash(C.sais, 0.14, "#ffb21f");
      pulse("#h-stamp span", C.sucre2, 1.06);
      const T1 = C.comment;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 + 0.35, 0.16);
      tl.to("#pillsvg", { opacity: 0, scale: 0.6, filter: "blur(8px)", transformOrigin: "540px 910px", duration: 0.3, ease: "power3.in" }, T1 + 0.3);
      D.glow("amber", T1, 0.25, 0.4); D.glow("cream", T1, 0.2, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.12, 0.12); D.popIn("#st" + n, t, 0.6); };

      // ================= ÉTAPE 1 =================
      step(1, C.e1);
      tl.fromTo("#pill2", { opacity: 0, y: -120 }, { opacity: 1, y: 0, duration: 0.45, ease: "bounce.out" }, C.avales - 0.1);
      tl.fromTo("#mg", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.contient - 0.1);
      pulse("#mg .v", C.aucun, 1.12);
      tl.to("#mg", { borderColor: "#ff5236", duration: 0.2 }, C.aucun);
      tl.fromTo("#bubble", { opacity: 0, scale: 0.6, transformOrigin: "20% 100%" }, { opacity: 1, scale: 1, duration: 0.38, ease: "back.out(2)" }, C.cerveau - 0.1);
      D.glow("amber", C.mieux, 0.5, 0.4);

      // ================= ÉTAPE 2 =================
      step(2, C.e2);
      out(["#pill2", "#mg", "#bubble"], C.e2 - 0.15);
      D.glow("amber", C.e2, 0.25, 0.4);
      tl.fromTo("#gauge", { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 0.35, ease: "expo.out" }, C.e2 + 0.3);
      D.blurIn("#g-lbl", C.e2 + 0.4);
      tl.fromTo("#rx1", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.endorphines - 0.15);
      tl.fromTo("#rx1 .ar", { y: 30 }, { y: 0, duration: 0.4, ease: "back.out(3)" }, C.endorphines);
      tl.fromTo("#rx2", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.dopamine - 0.15);
      tl.fromTo("#rx2 .ar", { y: 30 }, { y: 0, duration: 0.4, ease: "back.out(3)" }, C.dopamine);
      tl.fromTo("#rx3", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.lactivite - 0.15);
      tl.fromTo("#g-fill", { scaleY: 1, transformOrigin: "50% 100%" }, { scaleY: 0.45, duration: 0.8, ease: "power2.inOut" }, C.baisse - 0.2);
      tl.fromTo("#rx3 .ar", { y: -30 }, { y: 0, duration: 0.4, ease: "back.out(3)" }, C.baisse);
      D.glow("cold", C.baisse, 0.45, 0.4); D.glow("amber", C.baisse, 0.1, 0.4);

      // ================= ÉTAPE 3 : le contexte =================
      step(3, C.e3);
      out([".rx", "#gauge", "#g-lbl"], C.e3 - 0.15);
      D.glow("cold", C.e3, 0.1, 0.4); D.glow("amber", C.e3, 0.3, 0.4);
      D.popIn("#in3", C.etude - 0.1, 0.5);
      bar("#pb1", 85, C.n85, C.contexte);
      pulse("#pb1 .v", C.chere, 1.1);
      bar("#pb2", 61, C.n61, C.contexte + 0.12);
      D.glow("amber", C.n85, 0.5, 0.3);

      // ================= BONUS : Harvard =================
      out(["#st3", "#in3", "#pb1", "#pb2"], C.fou - 0.3);
      D.glow("amber", C.fou, 0.2, 0.4); D.glow("red", C.fou, 0.2, 0.4);
      D.popIn("#in4", C.harvard - 0.1, 0.5);
      D.blurIn("#b-t", C.savaient - 0.1);
      pulse("#b-t .a", C.savaient + 0.1, 1.1);
      bar("#pb3", 59, C.n59);
      bar("#pb4", 35, C.n35);
      D.glow("amber", C.n59, 0.5, 0.3); D.glow("red", C.n59, 0.05, 0.4);

      // ================= NOCEBO =================
      out(["#in4", "#b-t", "#pb3", "#pb4"], C.lautre - 0.2);
      D.glow("amber", C.lautre, 0.05, 0.4);
      tl.fromTo("#n-t", { opacity: 0, scale: 1.4, filter: "blur(10px)" }, { opacity: 1, scale: 1, filter: "blur(0px)", duration: 0.3, ease: "expo.out" }, C.nocebo - 0.15);
      D.shake(C.nocebo, 10);
      D.glow("red", C.nocebo, 0.55, 0.3);
      D.popIn("#in5", C.vaccins - 0.1, 0.5);
      tl.fromTo(".wn", { opacity: 0, scale: 0.5 }, { opacity: 1, scale: 1, duration: 0.3, stagger: 0.08, ease: "back.out(2)" }, C.n3 - 0.2);
      tl.to(".wn:nth-child(-n+3)", { borderColor: "#ff5236", color: "#ff5236", duration: 0.12, stagger: 0.12 }, C.n4 - 0.1);
      D.blurIn("#n-sub", C.dose - 0.6);
      D.stamp("#n-stamp span", C.venaient - 0.05, -4);
      D.flash(C.venaient, 0.14);
      pulse("#n-stamp span", C.lattente, 1.06);

      // ================= CHUTE =================
      out(["#n-t", "#warns", "#n-sub", "#n-stamp span", "#in5"], C.attention - 0.2);
      D.glow("red", C.attention, 0.3, 0.4);
      D.blurIn("#at-t", C.attention - 0.1);
      tl.fromTo("#ok1", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.guerit - 0.25);
      tl.fromTo("#ok2", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.agit - 0.15);
      D.glow("cold", C.ressens, 0.45, 0.4); D.glow("red", C.ressens, 0.1, 0.4);
      pulse("#ok2", C.ressens, 1.05);
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
