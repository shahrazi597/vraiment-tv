<!doctype html>
<html lang="fr" data-resolution="portrait">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=1080, height=1920" />
    <script src="assets/gsap.min.js"></script>
    <script src="assets/da.js"></script>
    <link rel="stylesheet" href="assets/da.css" />
    <style>
      #h-t1 { top: 300px; font-size: 100px; }
      #h-t2 { top: 300px; font-size: 100px; }
      #h-t2 .wsp, #h-t3 .wsp { opacity: 0; }
      #h-t3 { top: 300px; font-size: 104px; }
      #h-stamp { top: 545px; }
      #stage { position: absolute; inset: 0; }
      #stage svg, #hk { position: absolute; left: 0; top: 0; }
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 290px; height: 80px; }
      #infos { top: 384px; height: 80px; }
      #capshade { position: absolute; left: 0; right: 0; top: 1120px; height: 800px; opacity: 0;
        background: linear-gradient(180deg, rgba(11,11,14,0) 0%, rgba(11,11,14,.92) 9%, rgba(11,11,14,.97) 100%); }
      #tw-title { top: 300px; font-size: 90px; }
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

      <!-- la carte, dessinée une fois, réutilisée -->
      <svg width="0" height="0" style="position:absolute" aria-hidden="true">
        <defs>
          <linearGradient id="gCard" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0" stop-color="#25303d" /><stop offset="1" stop-color="#11161d" />
          </linearGradient>
          <linearGradient id="gChip" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0" stop-color="#ffe08a" /><stop offset="1" stop-color="#c98d12" />
          </linearGradient>
          <g id="cardface">
            <rect x="300" y="820" width="480" height="302" rx="30" fill="url(#gCard)" stroke="#ece6d6" stroke-width="4" />
            <rect x="350" y="925" width="78" height="60" rx="12" fill="url(#gChip)" />
            <path d="M389 925 v60 M350 945 h78 M350 965 h78" stroke="#9c6a06" stroke-width="3" fill="none" />
            <g fill="none" stroke="#ece6d6" stroke-width="6" stroke-linecap="round" opacity=".8">
              <path d="M690 935 q 12 20 0 40" /><path d="M706 925 q 20 30 0 60" /><path d="M722 915 q 28 40 0 80" />
            </g>
            <rect x="350" y="1050" width="220" height="20" rx="10" fill="#ece6d6" opacity=".25" />
          </g>
        </defs>
      </svg>

      <div id="cam">
        <!-- 1. Accroche -->
        <div id="s-hook" class="clip" data-start="0" data-duration="%%HOOK_D%%" data-track-index="1" data-track-kind="graphics">
          <svg id="hk" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g transform="translate(540 870) scale(1.3) translate(-540 -971)">
              <use href="#cardface" />
              <g id="h-batt" opacity="0" transform="translate(560 1000)">
                <rect x="0" y="0" width="120" height="60" rx="12" fill="none" stroke="#ff5236" stroke-width="7" />
                <rect x="120" y="18" width="12" height="24" rx="4" fill="#ff5236" />
                <path d="M-14 74 L146 -14" stroke="#ff5236" stroke-width="9" stroke-linecap="round" />
              </g>
            </g>
          </svg>
          <div id="h-t1" class="hl">Ta carte n'a<br />pas de <span class="r">batterie.</span></div>
          <div id="h-t2" class="hl"><span class="wsp">D'où</span> <span class="wsp">vient</span><br /><span class="wsp">son</span> <span class="wsp a">énergie&nbsp;?</span></div>
          <div id="h-t3" class="hl"><span class="wsp">Du</span><br /><span class="wsp c">terminal&nbsp;!</span></div>
          <div id="h-stamp" class="stamp"><span>Aucune&nbsp;!</span></div>
        </div>

        <!-- 2. Le mécanisme -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="stage">
            <svg width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
              <defs>
                <filter id="soft" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="22" /></filter>
              </defs>
              <!-- ondes du champ -->
              <g id="waves" fill="none" stroke="#4cc4ff" stroke-width="6"></g>
              <!-- terminal -->
              <g id="term" opacity="0">
                <rect x="370" y="470" width="340" height="230" rx="36" fill="#16161b" stroke="#ece6d6" stroke-width="6" />
                <rect x="400" y="496" width="280" height="92" rx="16" fill="#0b0b0e" />
                <text id="scr" x="540" y="557" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="38" fill="#4cc4ff">0</text>
                <g fill="none" stroke="#ece6d6" stroke-width="6" stroke-linecap="round" transform="translate(512 610)">
                  <path d="M6 14 q 8 14 0 28" /><path d="M20 6 q 14 22 0 44" /><path d="M34 -2 q 20 30 0 60" />
                </g>
              </g>
              <!-- la carte -->
              <g id="cardT">
                <ellipse id="chipglow" cx="389" cy="955" rx="90" ry="70" fill="#ffb21f" opacity="0" filter="url(#soft)" />
                <use id="cardU" href="#cardface" />
                <g id="coils" fill="none" stroke="#ffb21f" stroke-width="5" stroke-linejoin="round">
                  <rect class="coil" x="318" y="838" width="444" height="266" rx="18" />
                  <rect class="coil" x="332" y="852" width="416" height="238" rx="14" />
                  <rect class="coil" x="346" y="866" width="388" height="210" rx="10" />
                  <path class="coil" d="M346 955 H 350" />
                </g>
                <g id="curr"></g>
                <rect id="chipon" x="350" y="925" width="78" height="60" rx="12" fill="#fff3c4" opacity="0" />
                <text id="code" x="552" y="982" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="38" fill="#ffb21f" opacity="0">0000 0000</text>
              </g>
              <!-- le code qui remonte -->
              <g id="packet" opacity="0">
                <rect x="470" y="-24" width="140" height="48" rx="24" fill="#ffb21f" />
                <text x="540" y="11" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="30" fill="#0b0b0e">CODE</text>
              </g>
              <!-- distance -->
              <g id="dist" opacity="0" stroke="#ece6d6" stroke-width="5" stroke-linecap="round">
                <path d="M850 712 V 900" /><path d="M830 712 h40 M830 900 h40" />
                <text x="878" y="818" font-size="30" stroke="none" fill="#ece6d6" font-family="Inter Display" font-weight="800">quelques cm</text>
              </g>
            </svg>
          </div>

          <div id="capshade"></div>

          <div id="steps" class="row">
            <div id="st1" class="chip cold" style="position:absolute"><b>1</b>LE CHAMP</div>
            <div id="st2" class="chip amb" style="position:absolute"><b>2</b>LE COURANT</div>
            <div id="st3" class="chip hot" style="position:absolute"><b>3</b>LE CODE</div>
            <div id="st4" class="chip cold" style="position:absolute"><b>4</b>LA RÉPONSE</div>
          </div>
          <div id="infos" class="row">
            <div id="in0" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Une antenne tout autour de la carte</div>
            <div id="in1" class="chip" style="position:absolute"><i style="background:var(--cold)"></i>13,56 MHz : 13,56 millions d'oscillations / s</div>
            <div id="in2" class="chip" style="position:absolute"><i style="background:var(--amber)"></i>Champ magnétique → courant</div>
            <div id="in3" class="chip" style="position:absolute"><i style="background:var(--red)"></i>Code unique : 1 seul paiement</div>
            <div id="in4" class="chip" style="position:absolute"><i style="background:var(--cold)"></i>Elle répond en faisant varier le champ</div>
          </div>

          <div id="tw-title" class="hl"><span class="wsp">Et</span> <span class="wsp">si</span> <span class="wsp">tu</span> <span class="wsp c">l'éloignes&nbsp;?</span></div>
          <div id="tw-stamp" class="stamp"><span>Éteinte&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 3 · Le paiement sans contact</div>
          <div id="c-src">Sources : IEEE (Near Field Communication, 13,56 MHz) · EMVCo (EMV Contactless Chip)</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#3</span>
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

      // ================= 1. ACCROCHE =================
      D.glow("cold", 0, 0.45, 0.01);
      tl.to("#h-batt", { opacity: 1, duration: 0.2 }, C.batterie);
      tl.fromTo("#h-batt", { scale: 1.6, svgOrigin: "626 1030" }, { scale: 1, svgOrigin: "626 1030", duration: 0.3, ease: "back.out(2)" }, C.batterie);
      D.stamp("#h-stamp span", C.aucune, -5);
      D.shake(C.aucune + 0.02, 12);
      D.glow("red", C.aucune, 0.55, 0.3);
      D.blurOut(["#h-t1", "#h-stamp span", "#h-batt"], C.alors - 0.12, 0.14);
      tl.fromTo("#h-t2 .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.1, ease: "power2.out" }, C.alors);
      D.glow("red", C.alors, 0, 0.4); D.glow("amber", C.energie, 0.45, 0.4);
      D.blurOut("#h-t2", C.du - 0.1, 0.12);
      tl.fromTo("#h-t3 .wsp", { opacity: 0, filter: "blur(8px)", scale: 1.2 }, { opacity: 1, filter: "blur(0px)", scale: 1, duration: 0.18, stagger: 0.12, ease: "expo.out" }, C.du);
      D.glow("amber", C.terminal, 0, 0.3); D.glow("cold", C.terminal, 0.8, 0.3);
      D.flash(C.terminal + 0.05, 0.14, "#4cc4ff");
      const T1 = C.secret - 0.2;
      D.blurOut("#h-t3", T1 - 0.05, 0.15);
      tl.set("#hk", { opacity: 0 }, T1 + 0.1);

      // ================= la carte : position pilotée (centre x, centre y, échelle) =================
      const cardT = document.getElementById("cardT");
      const P = { cx: 540, cy: 870, s: 1.3 };
      const place = () => cardT.setAttribute("transform", `translate(${P.cx.toFixed(1)} ${P.cy.toFixed(1)}) scale(${P.s.toFixed(4)}) translate(-540 -971)`);
      place();
      const moveCard = (to, at, d = 0.7, ease = "power3.inOut") => tl.to(P, { ...to, duration: d, ease, onUpdate: place }, at);
      tl.fromTo("#stage", { opacity: 0 }, { opacity: 1, duration: 0.1 }, T1 + 0.05);
      tl.to("#capshade", { opacity: 1, duration: 0.3 }, T1 + 0.1);

      // ================= LE SECRET : L'ANTENNE =================
      tl.to("#cardU", { opacity: 0.35, duration: 0.4 }, C.antenne - 0.1);
      const coils = gsap.utils.toArray(".coil");
      coils.forEach((c) => { const L = c.getTotalLength(); c.style.strokeDasharray = L; c.style.strokeDashoffset = L; });
      coils.forEach((c, j) => tl.to(c, { strokeDashoffset: 0, duration: 0.9, ease: "power2.inOut" }, C.antenne + j * 0.15));
      D.popIn("#in0", C.antenne + 0.1, 0.5);
      D.glow("cold", C.antenne, 0.2, 0.4); D.glow("amber", C.antenne, 0.55, 0.4);
      tl.to("#cardU", { opacity: 1, duration: 0.4 }, C.e1 - 0.4);
      tl.to("#coils", { opacity: 0.35, duration: 0.4 }, C.e1 - 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.1, 0.12); D.popIn("#st" + n, t, 0.6); };

      // ================= ÉTAPE 1 — LE CHAMP =================
      D.blurOut("#in0", C.e1 - 0.2, 0.15);
      step(1, C.e1);
      moveCard({ cy: 1000, s: 0.85 }, C.e1 - 0.3);
      tl.fromTo("#term", { opacity: 0, y: -60 }, { opacity: 1, y: 0, duration: 0.45, ease: "expo.out" }, C.e1 + 0.1);
      D.glow("amber", C.e1, 0, 0.4); D.glow("cold", C.e1, 0.6, 0.4);
      // ondes : ellipses qui partent du terminal, en boucle finie
      const waves = document.getElementById("waves"), W = [];
      for (let j = 0; j < 5; j++) W.push(mk(waves, "ellipse", { cx: 540, cy: 700, rx: 60, ry: 18, opacity: 0 }));
      const P0 = 1.0, nrep = Math.ceil((C.abonne - C.cree) / P0);
      W.forEach((e, j) => tl.fromTo(e, { attr: { rx: 70, ry: 18 }, opacity: 0 },
        { keyframes: [{ opacity: 0.9, duration: 0.1 }, { attr: { rx: 420, ry: 170 }, opacity: 0, duration: P0 - 0.1, ease: "power1.out" }], repeat: nrep }, C.cree + j * P0 / W.length));
      D.popIn("#in1", C.oscille - 0.1, 0.5);
      // écran du terminal : une seule fonction du temps
      { const scr = document.getElementById("scr"), tc0 = C.treize - 0.3, o = { p: 0 };
        const grp = (n) => String(n).replace(/\B(?=(\d{3})+(?!\d))/g, " ");
        const at = (t) => { if (t >= C.et_si) return ["…", "#8e8c95"]; if (t >= C.varier + 0.2) return ["✓ PAYÉ", "#ffb21f"];
          if (t < tc0) return ["0 /s", "#4cc4ff"]; const k = Math.min(1, (t - tc0) / 1.4), e = 1 - (1 - k) * (1 - k);
          return [grp(Math.round(13560000 * e)) + " /s", t >= C.e2 ? "#ece6d6" : "#4cc4ff"]; };
        const T0 = C.e1 - 0.4, TD = C.abonne - T0;
        const upd = (t) => { const [txt, col] = at(t); scr.textContent = txt; scr.setAttribute("fill", col); };
        upd(T0); tl.to(o, { p: 1, duration: TD, ease: "none", onUpdate() { upd(T0 + this.progress() * TD); } }, T0); }

      // ================= ÉTAPE 2 — LE COURANT =================
      D.blurOut("#in1", C.e2 - 0.2, 0.15);
      step(2, C.e2);
      moveCard({ cy: 930, s: 1 }, C.approches - 0.15, 0.8, "power2.out");
      tl.to("#coils", { opacity: 1, duration: 0.3 }, C.traverse - 0.1);
      tl.fromTo("#coils", { filter: "drop-shadow(0 0 0px #ffb21f)" }, { filter: "drop-shadow(0 0 14px #ffb21f)", duration: 0.4 }, C.traverse);
      D.popIn("#in2", C.traverse, 0.5);
      D.glow("cold", C.traverse, 0.35, 0.4); D.glow("amber", C.traverse, 0.5, 0.4);
      // le courant tourne dans l'antenne
      { const curr = document.getElementById("curr"), path = document.querySelector(".coil:nth-of-type(2)");
        const L = path.getTotalLength(), N = 16, dots = Array.from({ length: N }, () => mk(curr, "circle", { r: 8, fill: "#fff3c4", opacity: 0 }));
        const t0 = C.courant - 0.3, t1 = C.et_si + 1.2, dur = t1 - t0, o = { p: 0 };
        const draw = (pr) => { const ph = pr * dur * 520; dots.forEach((d, j) => { const pt = path.getPointAtLength((ph + j * L / N) % L); d.setAttribute("cx", pt.x.toFixed(1)); d.setAttribute("cy", pt.y.toFixed(1)); }); };
        draw(0);
        tl.to(o, { p: 1, duration: dur, ease: "none", onUpdate() { draw(this.progress()); } }, t0);
        tl.to(dots, { opacity: 1, duration: 0.3, stagger: 0.02 }, C.courant - 0.2);
        tl.to(dots, { opacity: 0, duration: 0.5 }, C.centimetres); }
      // la puce se réveille
      tl.to("#chipglow", { opacity: 0.9, duration: 0.3 }, C.reveille - 0.05);
      tl.fromTo("#chipon", { opacity: 0 }, { keyframes: [{ opacity: 0.9, duration: 0.08 }, { opacity: 0.35, duration: 0.4 }] }, C.reveille - 0.05);
      D.flash(C.reveille, 0.14, "#ffb21f");

      // ================= ÉTAPE 3 — LE CODE UNIQUE =================
      D.blurOut("#in2", C.e3 - 0.2, 0.15);
      step(3, C.e3);
      D.glow("cold", C.e3, 0.15, 0.4); D.glow("red", C.e3, 0.4, 0.4);
      tl.to("#code", { opacity: 1, duration: 0.2 }, C.calcule - 0.1);
      { const codeEl = document.getElementById("code"), o = { v: 0 }, H = "0123456789ABCDEF";
        const finalC = "A7F3 9C21";
        tl.to(o, { v: 1, duration: 1.0, ease: "none", onUpdate: () => { const k = Math.floor(o.v * 24);
          codeEl.textContent = o.v >= 1 ? finalC : finalC.split("").map((c, i) => c === " " ? " " : H[(k * 7 + i * 5) % 16]).join(""); } }, C.calcule - 0.05); }
      D.popIn("#in3", C.seul - 0.2, 0.5);
      tl.fromTo("#code", { scale: 1, svgOrigin: "552 968" }, { keyframes: [{ scale: 1.15, duration: 0.1 }, { scale: 1, duration: 0.35, ease: "expo.out" }], svgOrigin: "552 968" }, C.seul);

      // ================= ÉTAPE 4 — LA RÉPONSE =================
      D.blurOut("#in3", C.e4 - 0.2, 0.15);
      step(4, C.e4);
      D.glow("red", C.e4, 0, 0.4); D.glow("cold", C.e4, 0.5, 0.4);
      tl.set("#packet", { opacity: 1, x: 70, y: 958 }, C.renvoie - 0.05);
      tl.to("#code", { opacity: 0.25, duration: 0.2 }, C.renvoie - 0.05);
      tl.to("#packet", { x: 0, y: 640, duration: 0.9, ease: "power2.inOut" }, C.renvoie);
      tl.to("#packet", { opacity: 0, scale: 0.5, svgOrigin: "540 640", duration: 0.2 }, C.renvoie + 0.9);
      D.popIn("#in4", C.varier - 0.3, 0.5);
      // les ondes changent de rythme (modulation) puis le terminal valide
      tl.to("#waves", { keyframes: [{ opacity: 0.4, duration: 0.08 }, { opacity: 1, duration: 0.08 }, { opacity: 0.4, duration: 0.08 }, { opacity: 1, duration: 0.08 }, { opacity: 0.4, duration: 0.08 }, { opacity: 1, duration: 0.08 }] }, C.varier - 0.1);
      tl.fromTo("#term", { scale: 1, svgOrigin: "540 585" }, { keyframes: [{ scale: 1.06, duration: 0.1 }, { scale: 1, duration: 0.35, ease: "expo.out" }], svgOrigin: "540 585" }, C.varier + 0.2);
      D.glow("amber", C.varier + 0.2, 0.5, 0.3);

      // ================= 5. LA CHUTE : ON L'ÉLOIGNE =================
      D.blurOut(["#in4", "#st4"], C.et_si - 0.2, 0.15);
      D.glow("amber", C.et_si, 0, 0.3); D.glow("cold", C.et_si, 0.3, 0.4);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.1, ease: "power2.out" }, C.et_si);
      moveCard({ cy: 1012, s: 0.8 }, C.eloignes - 0.1, 0.8, "power2.inOut");
      tl.to("#waves", { scale: 0.55, svgOrigin: "540 700", duration: 0.8, ease: "power2.inOut" }, C.eloignes);
      tl.to("#dist", { opacity: 1, duration: 0.3 }, C.centimetres - 0.1);
      tl.to("#coils", { opacity: 0.25, filter: "drop-shadow(0 0 0px #ffb21f)", duration: 0.5 }, C.plus2 - 0.1);
      tl.to(["#chipglow", "#chipon"], { opacity: 0, duration: 0.25 }, C.seteint - 0.1);
      tl.to("#cardU", { opacity: 0.55, duration: 0.3 }, C.seteint);
      D.blurOut("#tw-title", C.seteint - 0.14, 0.12);
      D.stamp("#tw-stamp span", C.seteint, -5);
      D.shake(C.seteint + 0.02, 12);
      D.flash(C.seteint + 0.02, 0.2, "#ff5236");
      D.glow("red", C.seteint, 0.6, 0.3);
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.3, ease: "power3.in" }, C.abonne - 0.32);
      tl.to("#capshade", { opacity: 0, duration: 0.2 }, C.abonne - 0.32);

      // ================= 6. CARTE DE FIN =================
      D.glow("red", C.abonne - 0.2, 0, 0.4); D.glow("cold", C.abonne - 0.2, 0, 0.4); D.glow("cream", C.abonne - 0.2, 0.5, 0.4);
      D.endCard(C.abonne - 0.05, C.vraiment);

      D.captions(CAP);
      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
