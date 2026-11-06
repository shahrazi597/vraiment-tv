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
      #h-stamp { top: 1150px; }
      #hk { position: absolute; left: 0; top: 0; }

      /* ---------- schéma ---------- */
      #stage { position: absolute; inset: 0; }
      #stage svg { position: absolute; left: 0; top: 0; }
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 290px; height: 80px; }
      #infos { top: 384px; height: 80px; }
      .wl { position: absolute; font-size: 30px; font-weight: 800; letter-spacing: .08em; opacity: 0; white-space: nowrap; }
      #wl-n { left: 380px; top: 500px; color: var(--red); }
      #wl-a { left: 380px; top: 975px; color: var(--cold); }
      #wl-s { left: 380px; top: 975px; color: var(--amber); }
      #wl-g { left: 110px; top: 510px; color: var(--cream); }
      #wl-v { left: 110px; top: 790px; color: var(--cream); }
      .res { position: absolute; right: 100px; font-size: 34px; font-weight: 900; letter-spacing: .04em; opacity: 0; white-space: nowrap; }
      #rs-g { top: 506px; color: var(--amber); }
      #rs-v { top: 786px; color: var(--red); }
      .src { position: absolute; top: 470px; display: flex; gap: 14px; }
      .src .chip { position: relative; }
      #srcs { left: 380px; top: 1040px; }
      #year { position: absolute; left: 0; right: 0; top: 560px; text-align: center; font-size: 250px; font-weight: 900; letter-spacing: -.05em;
        color: var(--amber); line-height: 1; opacity: 0; white-space: nowrap; }
      #tw-title { top: 300px; font-size: 96px; }
      #tw-title .wsp { opacity: 0; }
      #tw-stamp { top: 1010px; }
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
            <defs><filter id="hsoft" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="26" /></filter></defs>
            <g id="hmove" transform="translate(0 120)"><g id="hglow"><ellipse cx="540" cy="830" rx="250" ry="190" fill="#ff5236" opacity=".18" filter="url(#hsoft)" /></g>
            <g id="noise" fill="none" stroke="#ff5236" stroke-width="8" stroke-linecap="round">
              <path class="nz" d="M250 760 q -34 70 0 140" /><path class="nz" d="M205 730 q -54 100 0 200" /><path class="nz" d="M160 700 q -74 130 0 260" />
              <path class="nz" d="M830 760 q 34 70 0 140" /><path class="nz" d="M875 730 q 54 100 0 200" /><path class="nz" d="M920 700 q 74 130 0 260" />
            </g>
            <g id="phones">
              <path d="M330 860 V780 a210 200 0 0 1 420 0 V860" fill="none" stroke="#ece6d6" stroke-width="22" stroke-linecap="round" />
              <rect x="282" y="790" width="120" height="200" rx="46" fill="#16161b" stroke="#ece6d6" stroke-width="7" />
              <rect x="678" y="790" width="120" height="200" rx="46" fill="#16161b" stroke="#ece6d6" stroke-width="7" />
              <rect x="388" y="808" width="30" height="164" rx="15" fill="#ffb21f" />
              <rect x="662" y="808" width="30" height="164" rx="15" fill="#ffb21f" />
              <circle cx="300" cy="830" r="9" fill="#ff5236" /><circle cx="780" cy="830" r="9" fill="#ff5236" />
            </g></g>
          </svg>
          <div id="h-t1" class="hl"><span class="wsp" id="hw1">Pour faire le</span> <span class="wsp a" id="hw2">silence,</span><br /><span class="wsp" id="hw3">ton casque</span><br /><span class="wsp r" id="hw4">ajoute</span> <span class="wsp" id="hw5">du bruit&nbsp;!</span></div>
          <div id="h-stamp" class="stamp"><span>Un anti-bruit&nbsp;!</span></div>
        </div>

        <!-- 2. Le schéma -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="stage">
            <svg width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <defs><filter id="glw" x="-20%" y="-50%" width="140%" height="200%"><feGaussianBlur stdDeviation="7" /></filter></defs>
              <g id="cup" opacity="0">
                <path d="M118 650 c-40 10 -52 70 -34 110 c14 34 -10 60 4 96 c12 30 44 34 58 10" fill="none" stroke="#ece6d6" stroke-width="7" stroke-linecap="round" />
                <rect x="160" y="590" width="44" height="320" rx="22" fill="#ffb21f" />
                <rect x="198" y="560" width="140" height="380" rx="56" fill="#16161b" stroke="#ece6d6" stroke-width="7" />
                <path d="M268 560 V470 a60 60 0 0 1 60 -60 H360" fill="none" stroke="#ece6d6" stroke-width="16" stroke-linecap="round" opacity=".7" />
                <g id="spk"><circle cx="232" cy="750" r="26" fill="none" stroke="#ece6d6" stroke-width="5" /><circle cx="232" cy="750" r="10" fill="#ece6d6" /></g>
                <g id="mic1" opacity="0"><circle cx="338" cy="660" r="26" fill="#ff5236" opacity=".3" /><circle cx="338" cy="660" r="13" fill="#ff5236" /></g>
                <g id="mic2" opacity="0"><circle cx="214" cy="860" r="24" fill="#4cc4ff" opacity=".3" /><circle cx="214" cy="860" r="12" fill="#4cc4ff" /></g>
                <g id="chipic" opacity="0"><rect x="246" y="612" width="56" height="56" rx="10" fill="#ffb21f" /><rect x="260" y="626" width="28" height="28" rx="4" fill="#0b0b0e" /></g>
              </g>
              <line id="axis" x1="380" y1="760" x2="990" y2="760" stroke="#2a2a32" stroke-width="3" opacity="0" />
              <path id="pN" fill="none" stroke="#ff5236" stroke-width="9" stroke-linecap="round" opacity="0" />
              <path id="pA" fill="none" stroke="#4cc4ff" stroke-width="9" stroke-linecap="round" opacity="0" />
              <path id="pSg" fill="none" stroke="#ffb21f" stroke-width="22" stroke-linecap="round" opacity="0" filter="url(#glw)" />
              <path id="pS" fill="none" stroke="#ffb21f" stroke-width="11" stroke-linecap="round" opacity="0" />
              <g id="arrows" opacity="0" fill="none" stroke-width="7" stroke-linecap="round" stroke-linejoin="round">
                <g id="arNp"><path id="arN" d="M0 26 V-26 M-16 -10 L0 -26 L16 -10" stroke="#ff5236" /></g>
                <g id="arAp"><path id="arA" d="M0 -26 V26 M-16 10 L0 26 L16 10" stroke="#4cc4ff" /></g>
              </g>
              <path id="pG" fill="none" stroke="#ece6d6" stroke-width="9" stroke-linecap="round" opacity="0" />
              <path id="pGa" fill="none" stroke="#4cc4ff" stroke-width="6" stroke-linecap="round" opacity="0" stroke-dasharray="4 14" />
              <path id="pV" fill="none" stroke="#ece6d6" stroke-width="7" stroke-linecap="round" opacity="0" />
              <path id="pC" fill="none" stroke="#4cc4ff" stroke-width="11" stroke-linecap="round" opacity="0" />
            </svg>
          </div>
          <div id="wl-n" class="wl">LE BRUIT</div>
          <div id="wl-a" class="wl">L'ANTI-BRUIT</div>
          <div id="wl-s" class="wl">CE QUE TU ENTENDS</div>
          <div id="wl-g" class="wl">SONS GRAVES ET RÉGULIERS</div>
          <div id="wl-v" class="wl">VOIX, SONS AIGUS</div>
          <div id="rs-g" class="res">ANNULÉS&nbsp;✓</div>
          <div id="rs-v" class="res">PASSENT&nbsp;✕</div>
          <div id="srcs" class="src">
            <span id="sc1" class="chip"><i style="background:var(--red)"></i>Moteur d'avion</span>
            <span id="sc2" class="chip"><i style="background:var(--red)"></i>Métro</span>
          </div>
          <div id="year"><span id="yr">2026</span></div>

          <div id="steps" class="row">
            <div id="st1" class="chip hot"><b>1</b>LE MICRO ÉCOUTE</div>
            <div id="st2" class="chip cold"><b>2</b>L'ONDE INVERSE</div>
            <div id="st3" class="chip amb"><b>3</b>ELLES S'ANNULENT</div>
            <div id="st4" class="chip cold"><b>4</b>ON CORRIGE</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--red)"></i>Un micro sur l'écouteur</div>
            <div id="in2" class="chip"><i style="background:var(--cold)"></i>Bruit monte, anti-bruit descend</div>
            <div id="in3" class="chip"><i style="background:var(--amber)"></i>Bruit + anti-bruit = 0</div>
            <div id="in4" class="chip"><i style="background:var(--cold)"></i>2ᵉ micro, côté oreille</div>
            <div id="in5" class="chip"><i style="background:var(--amber)"></i>1ᵉʳ brevet&nbsp;: Paul Lueg</div>
          </div>

          <div id="tw-title" class="hl"><span class="wsp">Le</span> <span class="wsp a">silence</span> <span class="wsp">de</span><br /><span class="wsp">ton</span> <span class="wsp">casque&nbsp;?</span></div>
          <div id="tw-stamp" class="stamp"><span>À l'envers&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 5 · Le casque anti-bruit</div>
          <div id="c-src">Sources : brevet US 2 043 416 (P. Lueg, 1936) · Bose, histoire de la réduction de bruit active · BBC Science Focus</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#5</span>
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

      // ---------- ondes : tout est fonction du temps t (aucun état) ----------
      const ease = (x) => (x <= 0 ? 0 : x >= 1 ? 1 : x * x * (3 - 2 * x));
      const R = (t, t0, d, a, b) => a + (b - a) * ease((t - t0) / d);
      const X0 = 380, X1 = 990, NP = 120;
      const noise = (x, t) => 0.64 * Math.sin(x * 0.026 + t * 5.2) + 0.36 * Math.sin(x * 0.061 + t * 8.3 + 1.1);
      const path = (fy, x0 = X0, x1 = X1, n = NP) => { let d = ""; for (let i = 0; i <= n; i++) { const x = x0 + (x1 - x0) * i / n; d += (i ? "L" : "M") + x.toFixed(1) + " " + fy(x).toFixed(1); } return d; };
      const el = (id) => document.getElementById(id);
      const pN = el("pN"), pA = el("pA"), pS = el("pS"), pSg = el("pSg"), pG = el("pG"), pGa = el("pGa"), pV = el("pV"), pC = el("pC");
      const AMP = 92;
      const draw = (t) => {
        // centres : séparés puis réunis à « s'additionnent »
        const yN = R(t, C.sadditionnent - 0.2, 0.7, 640, 760), yA = R(t, C.sadditionnent - 0.2, 0.7, 880, 760);
        const rev = R(t, C.dessine - 0.1, 1.1, 0, 1);                       // l'anti-bruit se dessine de gauche à droite
        const xa = X0 + (X1 - X0) * rev;
        pN.setAttribute("d", path((x) => yN - AMP * noise(x, t)));
        pA.setAttribute("d", rev > 0.002 ? path((x) => yA + AMP * noise(x, t), X0, xa, Math.max(2, Math.round(NP * rev))) : "M0 0");
        // le résultat : ce qui reste du bruit (annulation, puis petit résidu corrigé à l'étape 4)
        const k = R(t, C.sannulent - 0.15, 0.55, 1, 0) + R(t, C.reste - 0.3, 0.4, 0, 0.22) - R(t, C.corrige, 0.6, 0, 0.21);
        const sd = path((x) => 760 - AMP * k * noise(x, t));
        pS.setAttribute("d", sd); pSg.setAttribute("d", sd);
        // bonus : graves (annulés) et aigus (passent)
        const kg = R(t, C.moteur - 0.1, 0.6, 1, 0.06);
        pG.setAttribute("d", path((x) => 650 - 80 * kg * Math.sin((x - 100) * 0.018 + t * 3.2), 110, 970));
        pGa.setAttribute("d", path((x) => 650 + 80 * Math.sin((x - 100) * 0.018 + t * 3.2), 110, 970));
        pV.setAttribute("d", path((x) => 930 - 70 * (0.5 * Math.sin(x * 0.11 + t * 13) + 0.3 * Math.sin(x * 0.23 - t * 17 + 2) + 0.2 * Math.sin(x * 0.047 + t * 7)) * (0.6 + 0.4 * Math.sin(x * 0.02 + t * 2.3)), 110, 970, 240));
        // chute : l'onde se retourne
        const fl = R(t, C.lenvers - 0.15, 0.45, 1, -1);
        pC.setAttribute("d", path((x) => 760 - 110 * fl * noise(x, t), 110, 970));
        const ar = el("arrows"), pk = 0.5 + 0.5 * Math.sin(t * 6);
        el("arNp").setAttribute("transform", `translate(930 ${yN - 140})`); el("arAp").setAttribute("transform", `translate(930 ${yA + 140})`);
      };
      const clock = { t: 0 };
      tl.to(clock, { t: C.end, duration: C.end, ease: "none", onUpdate: () => draw(clock.t) }, 0);

      // ================= 1. ACCROCHE =================
      D.glow("red", 0, 0.45, 0.01);
      gsap.utils.toArray("#noise .nz").forEach((w, j) => tl.fromTo(w, { opacity: 0.2 }, { opacity: 1, duration: 0.25, yoyo: true, repeat: 7, ease: "sine.inOut" }, (j % 3) * 0.1));
      const pulse = (sel, at) => tl.fromTo(sel, { scale: 1 }, { keyframes: [{ scale: 1.1, duration: 0.08 }, { scale: 1, duration: 0.25, ease: "expo.out" }] }, at);
      pulse("#hw2", C.silence); pulse("#hw4", C.ajoute);
      D.shake(C.ajoute + 0.02, 10);
      D.flash(C.ajoute + 0.02, 0.16);
      tl.fromTo("#phones", { scale: 1 }, { keyframes: [{ scale: 1.06, duration: 0.08 }, { scale: 1, duration: 0.2 }], svgOrigin: "540 860" }, C.bruit);
      D.stamp("#h-stamp span", C.antibruit, -5);
      D.glow("cold", C.antibruit, 0.45, 0.3);
      // le casque devient le schéma : il glisse à gauche et se tourne de profil
      const T1 = C.comment - 0.2;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 - 0.1, 0.18);
      tl.to("#hk", { x: -300, scale: 0.7, opacity: 0, transformOrigin: "300px 860px", duration: 0.35, ease: "power3.in" }, T1 - 0.1);
      tl.to("#cup", { opacity: 1, duration: 0.01 }, T1 + 0.05);
      tl.fromTo("#cup", { x: 120, scale: 1.15, svgOrigin: "250 750" }, { x: 0, scale: 1, svgOrigin: "250 750", duration: 0.45, ease: "expo.out" }, T1 + 0.05);
      tl.fromTo("#stage", { filter: "blur(10px)" }, { filter: "blur(0px)", duration: 0.4 }, T1 + 0.05);
      D.glow("red", T1, 0.15, 0.4); D.glow("cold", T1, 0, 0.4); D.glow("cream", T1, 0.35, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.1, 0.12); D.popIn("#st" + n, t, 0.6); };
      const info = (n, t, out) => { D.popIn("#in" + n, t, 0.5); if (out) D.blurOut("#in" + n, out, 0.15); };

      // ================= ÉTAPE 1 : le micro écoute =================
      step(1, C.e1);
      tl.to("#mic1", { opacity: 1, duration: 0.2 }, C.micro - 0.1);
      tl.fromTo("#mic1", { scale: 0.3 }, { scale: 1, svgOrigin: "338 660", duration: 0.35, ease: "back.out(2.6)" }, C.micro - 0.1);
      info(1, C.micro, C.e2 - 0.2);
      tl.to("#axis", { opacity: 1, duration: 0.3 }, C.ecoute - 0.2);
      tl.to("#pN", { opacity: 1, duration: 0.35 }, C.bruit1 - 0.15);
      D.blurIn("#wl-n", C.bruit1);
      D.glow("red", C.bruit1, 0.4, 0.4);
      D.popIn("#sc1", C.moteur1 - 0.05, 0.5);
      D.popIn("#sc2", C.metro - 0.05, 0.5);
      D.blurOut(["#sc1", "#sc2"], C.e2 - 0.2, 0.15);
      tl.to("#mic1", { keyframes: [{ scale: 1.35, duration: 0.12 }, { scale: 1, duration: 0.3 }], svgOrigin: "338 660" }, C.ecoute);

      // ================= ÉTAPE 2 : l'onde inverse =================
      step(2, C.e2);
      tl.to("#chipic", { opacity: 1, duration: 0.25 }, C.puce - 0.1);
      tl.fromTo("#chipic", { scale: 0.3 }, { scale: 1, svgOrigin: "274 640", duration: 0.35, ease: "back.out(2.4)" }, C.puce - 0.1);
      tl.to("#pA", { opacity: 1, duration: 0.1 }, C.dessine - 0.1);
      D.blurIn("#wl-a", C.londe);
      D.glow("cold", C.dessine, 0.45, 0.4); D.glow("red", C.dessine, 0.25, 0.4);
      info(2, C.quand1 - 0.1, C.e3 - 0.2);
      tl.to("#arrows", { opacity: 1, duration: 0.2 }, C.monte1 - 0.1);
      tl.fromTo("#arN", { scale: 0.4, transformOrigin: "50% 50%" }, { scale: 1, duration: 0.3, ease: "back.out(2.5)" }, C.monte1 - 0.1);
      tl.fromTo("#arA", { scale: 0.4, transformOrigin: "50% 50%" }, { scale: 1, duration: 0.3, ease: "back.out(2.5)" }, C.descend1 - 0.1);
      tl.to("#arN", { rotation: 180, transformOrigin: "50% 50%", duration: 0.3, ease: "power2.inOut" }, C.descend2 - 0.1);
      tl.to("#arA", { rotation: 180, transformOrigin: "50% 50%", duration: 0.3, ease: "power2.inOut" }, C.monte2 - 0.1);
      tl.to("#arrows", { opacity: 0, duration: 0.2 }, C.e3 - 0.2);

      // ================= ÉTAPE 3 : elles s'annulent =================
      step(3, C.e3);
      tl.to("#spk", { keyframes: [{ scale: 1.3, duration: 0.1 }, { scale: 1, duration: 0.25 }, { scale: 1.3, duration: 0.1 }, { scale: 1, duration: 0.25 }], svgOrigin: "232 750" }, C.joue - 0.1);
      D.blurOut(["#wl-n", "#wl-a"], C.sadditionnent - 0.25, 0.2);
      tl.to(["#pN", "#pA"], { opacity: 0.28, duration: 0.5 }, C.sadditionnent + 0.1);
      tl.to(["#pS"], { opacity: 1, duration: 0.3 }, C.sadditionnent + 0.2);
      tl.to(["#pSg"], { opacity: 0.6, duration: 0.3 }, C.sannulent);
      info(3, C.sannulent - 0.1, C.e4 - 0.2);
      D.blurIn("#wl-s", C.silence2 - 0.2);
      D.glow("cold", C.sannulent, 0.1, 0.4); D.glow("red", C.sannulent, 0, 0.4); D.glow("amber", C.sannulent, 0.6, 0.4);
      D.flash(C.silence2, 0.14, "#ffb21f");
      D.shake(C.silence2 + 0.02, 8);
      tl.to(["#pN", "#pA"], { opacity: 0, duration: 0.4 }, C.silence2 + 0.3);

      // ================= ÉTAPE 4 : le deuxième micro corrige =================
      step(4, C.e4);
      tl.to("#mic2", { opacity: 1, duration: 0.2 }, C.deuxieme - 0.1);
      tl.fromTo("#mic2", { scale: 0.3 }, { scale: 1, svgOrigin: "214 860", duration: 0.35, ease: "back.out(2.6)" }, C.deuxieme - 0.1);
      info(4, C.micro2 - 0.1, C.fou - 0.3);
      tl.to("#mic2", { keyframes: [{ scale: 1.4, duration: 0.12 }, { scale: 1, duration: 0.3 }, { scale: 1.4, duration: 0.12 }, { scale: 1, duration: 0.3 }], svgOrigin: "214 860" }, C.ecoute2);
      tl.to("#chipic", { keyframes: [{ opacity: 0.4, duration: 0.15 }, { opacity: 1, duration: 0.15 }, { opacity: 0.4, duration: 0.15 }, { opacity: 1, duration: 0.15 }] }, C.corrige);
      D.glow("amber", C.e4, 0.35, 0.4); D.glow("cold", C.e4, 0.35, 0.4);

      // ================= BONUS : graves contre aigus =================
      D.blurOut(["#st4"], C.fou - 0.3, 0.15);
      tl.to(["#cup", "#axis", "#pS", "#pSg", "#wl-s"], { opacity: 0, duration: 0.3 }, C.fou - 0.3);
      D.glow("amber", C.fou, 0.15, 0.4); D.glow("cold", C.fou, 0.2, 0.4); D.glow("cream", C.fou, 0.3, 0.4);
      D.blurIn("#wl-g", C.graves - 0.15);
      tl.to("#pG", { opacity: 1, duration: 0.3 }, C.graves - 0.15);
      tl.to("#pGa", { opacity: 0.9, duration: 0.3 }, C.reguliers - 0.1);
      tl.to("#pG", { stroke: "#ffb21f", duration: 0.3 }, C.moteur - 0.1);
      D.popIn("#rs-g", C.moteur, 0.5);
      tl.to("#pGa", { opacity: 0, duration: 0.4 }, C.moteur + 0.5);
      D.blurIn("#wl-v", C.voix - 0.15);
      tl.to("#pV", { opacity: 1, duration: 0.3 }, C.voix - 0.1);
      D.popIn("#rs-v", C.passent, 0.5);
      tl.to("#pV", { stroke: "#ff5236", duration: 0.3 }, C.passent);
      D.glow("red", C.passent, 0.35, 0.4);
      tl.fromTo("#pV", { scale: 1 }, { keyframes: [{ scale: 1.06, duration: 0.1 }, { scale: 1, duration: 0.25 }], svgOrigin: "540 930" }, C.voisin);

      // 1936
      tl.to(["#pG", "#pV", "#wl-g", "#wl-v", "#rs-g", "#rs-v"], { opacity: 0, filter: "blur(8px)", duration: 0.25 }, C.lidee - 0.2);
      D.glow("red", C.lidee, 0, 0.4); D.glow("cream", C.lidee, 0.2, 0.4); D.glow("amber", C.lidee, 0.55, 0.4);
      D.blurIn("#year", C.lidee);
      D.count("yr", 2026, 1936, C.lidee + 0.05, C.y1936 - C.lidee + 0.1, 0);
      tl.fromTo("#year", { scale: 1 }, { keyframes: [{ scale: 1.08, duration: 0.1 }, { scale: 1, duration: 0.3, ease: "expo.out" }] }, C.y1936 + 0.15);
      info(5, C.y1936 + 0.1, C.silenceC - 0.3);

      // ================= LA CHUTE : du bruit à l'envers =================
      tl.to("#year", { opacity: 0, filter: "blur(10px)", duration: 0.2 }, C.silenceC - 0.35);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.1, ease: "power2.out" }, C.silenceC - 0.2);
      D.glow("amber", C.silenceC, 0.2, 0.4); D.glow("cold", C.silenceC, 0.5, 0.4);
      tl.to("#pC", { opacity: 1, duration: 0.3 }, C.bruitC - 0.2);
      D.stamp("#tw-stamp span", C.lenvers, -5);
      D.shake(C.lenvers + 0.02, 12);
      D.glow("red", C.lenvers, 0.5, 0.3);
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
