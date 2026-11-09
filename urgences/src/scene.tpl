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
      .hc { position: absolute; left: 140px; width: 800px; height: 210px; border-radius: 32px; background: var(--panel); border: 4px solid var(--line);
        display: flex; flex-direction: column; justify-content: center; padding: 0 48px; }
      .hc .k { font-size: 34px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); white-space: nowrap; }
      .hc .v { font-size: 112px; font-weight: 900; letter-spacing: -.045em; line-height: 1; white-space: nowrap; }
      #hc-a { top: 560px; border-color: var(--amber); } #hc-a .v { color: var(--amber); }
      #hc-b { top: 810px; border-color: var(--red); opacity: 0; } #hc-b .v { color: var(--red); }
      #cross { position: absolute; left: 0; top: 0; }

      /* ---------- parties ---------- */
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 300px; height: 80px; }
      #infos { top: 392px; height: 80px; }

      /* ta part : le ticket */
      #ticket { position: absolute; left: 190px; top: 500px; width: 700px; height: 300px; border-radius: 30px; background: var(--cream); color: var(--ground);
        text-align: center; opacity: 0; }
      #ticket .k { margin-top: 40px; font-size: 34px; font-weight: 900; letter-spacing: .06em; text-transform: uppercase; }
      #ticket .v { font-size: 150px; font-weight: 900; letter-spacing: -.05em; line-height: 1.05; white-space: nowrap; }
      #ticket .s { font-size: 30px; font-weight: 800; color: #5d5b64; }
      #ticket::before, #ticket::after { content: ""; position: absolute; top: 130px; width: 44px; height: 44px; border-radius: 50%; background: var(--ground); }
      #ticket::before { left: -22px; } #ticket::after { right: -22px; }
      .sc { position: absolute; top: 850px; width: 400px; height: 250px; border-radius: 30px; background: var(--panel); border: 4px solid var(--line);
        text-align: center; opacity: 0; }
      .sc .k { margin-top: 34px; font-size: 32px; font-weight: 800; letter-spacing: .04em; text-transform: uppercase; color: var(--muted); line-height: 1.15; }
      .sc .v { margin-top: 10px; font-size: 92px; font-weight: 900; letter-spacing: -.045em; color: var(--amber); white-space: nowrap; }
      #sc-a { left: 90px; } #sc-b { left: 590px; }
      #eq { position: absolute; left: 490px; width: 100px; top: 920px; text-align: center; font-size: 100px; font-weight: 900; color: var(--ink); opacity: 0; }
      #hosp { position: absolute; left: 90px; top: 850px; width: 900px; height: 250px; border-radius: 30px; background: var(--panel); border: 4px solid var(--cold);
        display: flex; align-items: center; justify-content: space-around; opacity: 0; }
      #hosp .col { text-align: center; min-width: 320px; }
      #hosp .k { font-size: 30px; font-weight: 800; letter-spacing: .04em; text-transform: uppercase; color: var(--muted); }
      #hosp .v { font-size: 84px; font-weight: 900; letter-spacing: -.045em; white-space: nowrap; }
      #hosp .v.x { color: var(--muted); text-decoration: line-through; text-decoration-color: var(--red); text-decoration-thickness: 8px; }
      #hosp .v.c { color: var(--cold); }
      #hosp .ar { font-size: 70px; font-weight: 900; color: var(--cold); }

      /* le vrai prix */
      .pc { position: absolute; top: 500px; width: 430px; height: 260px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        text-align: center; opacity: 0; }
      .pc .k { margin-top: 36px; font-size: 32px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; color: var(--muted); }
      .pc .v { margin-top: 8px; font-size: 96px; font-weight: 900; letter-spacing: -.045em; line-height: 1.05; white-space: nowrap; }
      .pc .s { font-size: 30px; font-weight: 700; color: var(--muted); }
      #pc-a { left: 90px; } #pc-a .v { color: var(--red); }
      #pc-b { left: 560px; } #pc-b .v { color: var(--cream); }
      #div { position: absolute; z-index: 3; left: 505px; top: 590px; width: 70px; text-align: center; font-size: 80px; font-weight: 900; color: var(--muted); opacity: 0; }
      #avg { position: absolute; left: 0; right: 0; top: 790px; text-align: center; opacity: 0; }
      #avg .v { font-size: 170px; font-weight: 900; letter-spacing: -.05em; color: var(--amber); line-height: 1; white-space: nowrap; }
      #avg .s { font-size: 40px; font-weight: 800; color: var(--ink); text-transform: uppercase; letter-spacing: .02em; }
      #share { position: absolute; left: 90px; top: 830px; width: 900px; height: 120px; border-radius: 26px; overflow: hidden; border: 5px solid var(--cream);
        background: #111115; opacity: 0; }
      #sh-am { position: absolute; left: 0; top: 0; bottom: 0; width: 95%; background: var(--cold); display: flex; align-items: center; padding-left: 34px;
        font-size: 44px; font-weight: 900; color: var(--ground); white-space: nowrap; }
      #sh-lbl { position: absolute; left: 90px; top: 970px; font-size: 34px; font-weight: 800; color: var(--muted); opacity: 0; white-space: nowrap; }
      #sh-lbl b { color: var(--cold); }

      /* bonus : 3 heures */
      #clock { position: absolute; left: 0; top: 0; }
      #b-num { position: absolute; left: 500px; top: 560px; font-size: 220px; font-weight: 900; letter-spacing: -.05em; color: var(--amber); line-height: 1; opacity: 0; white-space: nowrap; }
      #b-sub { position: absolute; left: 500px; top: 790px; font-size: 40px; font-weight: 800; color: var(--muted); text-transform: uppercase; opacity: 0; white-space: nowrap; }
      #b-k { position: absolute; left: 0; right: 0; top: 440px; text-align: center; font-size: 46px; font-weight: 900; text-transform: uppercase; opacity: 0; white-space: nowrap; }
      #b-k .a { color: var(--amber); }
      #ppl { position: absolute; left: 0; top: 0; }

      /* chute : ta part */
      .bar { position: absolute; left: 90px; height: 120px; border-radius: 24px; opacity: 0; display: flex; align-items: center; padding-left: 30px;
        font-size: 50px; font-weight: 900; white-space: nowrap; color: var(--ground); }
      #bar-a { top: 560px; width: 77px; background: var(--amber); }
      #bar-b { top: 780px; width: 900px; background: var(--cream); }
      .bl { position: absolute; left: 90px; font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; color: var(--muted); opacity: 0; white-space: nowrap; }
      #bl-a { top: 500px; } #bl-b { top: 720px; }
      #bar-a-v { position: absolute; left: 200px; top: 572px; font-size: 84px; font-weight: 900; letter-spacing: -.04em; color: var(--amber); opacity: 0; white-space: nowrap; }
      #e-stamp { top: 990px; }
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
          <div id="h-t1" class="hl">Un passage<br />aux <span class="r">urgences</span></div>
          <div id="hc-a" class="hc"><div class="k">Toi, tu paies</div><div class="v">23&nbsp;€</div></div>
          <div id="hc-b" class="hc"><div class="k">Ça coûte en moyenne</div><div class="v">+ de 10&nbsp;×</div></div>
        </div>

        <!-- 2. Le détail -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="steps" class="row">
            <div id="st1" class="chip amb"><b>1</b>TA PART</div>
            <div id="st2" class="chip hot"><b>2</b>LE VRAI PRIX</div>
            <div id="st3" class="chip"><b>+</b>BONUS</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--amber)"></i>Mutuelle «&nbsp;responsable&nbsp;» : elle rembourse</div>
            <div id="in2" class="chip"><i style="background:var(--cold)"></i>Payé surtout par tes cotisations et ta CSG</div>
          </div>

          <!-- ta part -->
          <div id="ticket"><div class="k">Forfait patient urgences</div><div class="v">23&nbsp;€</div><div class="s">fixe, depuis mars 2026</div></div>
          <div id="sc-a" class="sc"><div class="k">Une simple<br />consultation</div><div class="v">23&nbsp;€</div></div>
          <div id="eq">=</div>
          <div id="sc-b" class="sc"><div class="k">Radio +<br />points de suture</div><div class="v">23&nbsp;€</div></div>
          <div id="hosp">
            <div class="col"><div class="k">Hospitalisé ?</div><div class="v x">23&nbsp;€</div></div>
            <div class="ar">→</div>
            <div class="col"><div class="k">Par jour d'hôpital</div><div class="v c">23&nbsp;€</div></div>
          </div>

          <!-- le vrai prix -->
          <div id="pc-a" class="pc"><div class="k">Les urgences</div><div class="v"><span id="v-56">0</span>&nbsp;Md€</div><div class="s">en 2023</div></div>
          <div id="div">÷</div>
          <div id="pc-b" class="pc"><div class="k">Passages</div><div class="v"><span id="v-208">0</span>&nbsp;M</div><div class="s">en 2023</div></div>
          <div id="avg"><div class="v">≈&nbsp;<span id="v-270">0</span>&nbsp;€</div><div class="s">par passage, en moyenne</div></div>
          <div id="share"><div id="sh-am">95&nbsp;% Assurance maladie</div></div>
          <div id="sh-lbl">Coût total des urgences : <b>95&nbsp;%</b> pour la Sécu</div>

          <!-- bonus -->
          <div id="b-k"><span class="a">La moitié</span> des patients</div>
          <svg id="clock" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="clk" opacity="0">
              <circle cx="300" cy="700" r="170" fill="#16161b" stroke="#ece6d6" stroke-width="10" />
              <path id="arc" d="M300 530 A170 170 0 0 1 470 700" fill="none" stroke="#ffb21f" stroke-width="22" stroke-linecap="round" />
              <g stroke="#ece6d6" stroke-width="8" stroke-linecap="round"><line x1="300" y1="550" x2="300" y2="575" /><line x1="450" y1="700" x2="425" y2="700" /><line x1="300" y1="850" x2="300" y2="825" /><line x1="150" y1="700" x2="175" y2="700" /></g>
              <line id="hand" x1="300" y1="700" x2="300" y2="590" stroke="#ffb21f" stroke-width="12" stroke-linecap="round" />
              <circle cx="300" cy="700" r="14" fill="#ffb21f" />
            </g>
          </svg>
          <div id="b-num">+3&nbsp;h</div>
          <div id="b-sub">aux urgences</div>
          <svg id="ppl" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <defs><g id="person"><circle cx="0" cy="-58" r="22" /><path d="M-34 0 v-18 a34 30 0 0 1 68 0 v18 z" /></g></defs>
            <g id="pp"></g>
          </svg>

          <!-- chute -->
          <div id="bl-a" class="bl">Ta part</div>
          <div id="bar-a" class="bar"></div>
          <div id="bar-a-v">23&nbsp;€</div>
          <div id="bl-b" class="bl">Le coût moyen d'un passage</div>
          <div id="bar-b" class="bar">≈ 270&nbsp;€</div>
          <div id="e-stamp" class="stamp"><span>C'est juste ta part&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Combien ça</div><div>coûte</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 7 · Un passage aux urgences</div>
          <div id="c-src">Sources : Cour des comptes (2024) ; Drees (2023) ; arrêté du 27/02/2026</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMBIEN ÇA COÛTE VRAIMENT&nbsp;?</span><span class="pill num">#7</span>
      </div>

      <div id="fx" class="clip" data-start="0" data-duration="%%END%%" data-track-index="7" data-track-kind="graphics">
        <div id="flash"></div>
      </div>
    </div>

    <script>
      const C = %%CUES%%;
      const CAP = %%CAPDATA%%;
      const NS = "http://www.w3.org/2000/svg";
      DA.fitCaptions(CAP);
      const tl = gsap.timeline({ paused: true });
      const D = DA(tl);
      D.drift(C.end);
      const pulse = (sel, at, s = 1.08) => tl.fromTo(sel, { scale: 1 }, { keyframes: [{ scale: s, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, at);
      const out = (sel, at, d = 0.25) => tl.to(sel, { opacity: 0, filter: "blur(10px)", duration: d }, at);
      const sp = (v) => Math.round(v).toLocaleString("fr-FR").replace(/ | |,/g, " ");
      const countInt = (id, a, b, at, d) => { const o = { v: a }, el = document.getElementById(id);
        tl.to(o, { v: b, duration: d, ease: "power2.out", onUpdate: () => (el.textContent = sp(o.v)) }, at); };

      // ================= 1. ACCROCHE =================
      D.glow("amber", 0, 0.4, 0.01);
      pulse("#hc-a", C.n23 - 0.05, 1.06);
      tl.fromTo("#hc-b", { opacity: 0, y: 60, scale: 0.85 }, { opacity: 1, y: 0, scale: 1, duration: 0.35, ease: "back.out(2)" }, C.coute - 0.1);
      pulse("#hc-b .v", C.n10 - 0.05, 1.12);
      D.shake(C.n10, 11);
      D.flash(C.n10, 0.16);
      D.glow("red", C.n10, 0.55, 0.3); D.glow("amber", C.n10, 0.1, 0.4);
      const T1 = C.combien;
      D.blurOut(["#h-t1", "#hc-a", "#hc-b"], T1 + 0.3, 0.16);
      D.glow("red", T1, 0.15, 0.4); D.glow("amber", T1, 0.3, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.12, 0.12); D.popIn("#st" + n, t, 0.6); };

      // ================= 1. TA PART =================
      step(1, C.ta - 0.1);
      tl.fromTo("#ticket", { opacity: 0, y: 80, rotation: -4 }, { opacity: 1, y: 0, rotation: 0, duration: 0.45, ease: "back.out(1.6)" }, C.depuis - 0.2);
      pulse("#ticket .v", C.n23b - 0.05, 1.1);
      D.glow("amber", C.n23b, 0.55, 0.3);
      tl.fromTo("#sc-a", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.consultation - 0.2);
      tl.fromTo("#sc-b", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.radio - 0.15);
      D.popIn("#eq", C.suture - 0.1, 0.4);
      tl.to(["#sc-a", "#sc-b"], { borderColor: "#ffb21f", duration: 0.2 }, C.suture);
      D.popIn("#in1", C.mutuelle - 0.1, 0.5);
      tl.to("#ticket", { rotation: -3, duration: 0.3, ease: "back.out(2)" }, C.rembourse);
      out(["#sc-a", "#sc-b", "#eq"], C.hospitalise - 0.25);
      tl.fromTo("#hosp", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.hospitalise - 0.05);
      D.glow("cold", C.hospitalise, 0.35, 0.4); D.glow("amber", C.hospitalise, 0.2, 0.4);
      pulse("#hosp .v.c", C.n23c - 0.05, 1.12);

      // ================= 2. LE VRAI PRIX =================
      step(2, C.maintenant);
      out(["#in1", "#ticket", "#hosp"], C.maintenant - 0.15);
      D.glow("cold", C.maintenant, 0, 0.4); D.glow("red", C.maintenant, 0.35, 0.4); D.glow("amber", C.maintenant, 0.1, 0.4);
      tl.fromTo("#pc-a", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.urgences2 - 0.1);
      D.count("v-56", 0, 5.6, C.n56 - 0.1, 0.9, 1);
      tl.fromTo("#pc-b", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.n208 - 0.25);
      D.count("v-208", 0, 20.8, C.n208 - 0.1, 0.9, 1);
      D.popIn("#div", C.passages, 0.5);
      tl.fromTo("#avg", { opacity: 0, scale: 0.7 }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2)" }, C.n270 - 0.25);
      countInt("v-270", 0, 270, C.n270 - 0.2, 0.9);
      D.glow("amber", C.n270, 0.5, 0.3); D.glow("red", C.n270, 0.15, 0.4);
      D.flash(C.n270 + 0.6, 0.12, "#ffb21f");
      out("#avg", C.n95 - 0.3);
      tl.fromTo("#share", { opacity: 0 }, { opacity: 1, duration: 0.2 }, C.n95 - 0.15);
      tl.fromTo("#sh-am", { scaleX: 0, transformOrigin: "0% 50%" }, { scaleX: 1, duration: 0.6, ease: "power3.out" }, C.n95 - 0.1);
      D.blurIn("#sh-lbl", C.lassurance);
      D.glow("cold", C.lassurance, 0.4, 0.4); D.glow("amber", C.lassurance, 0.1, 0.4);
      D.popIn("#in2", C.donc - 0.1, 0.5);

      // ================= BONUS : 3 heures =================
      step(3, C.bonus - 0.1);
      out(["#in2", "#pc-a", "#pc-b", "#div", "#share", "#sh-lbl"], C.bonus - 0.25);
      D.glow("cold", C.bonus, 0, 0.4); D.glow("red", C.bonus, 0.1, 0.4); D.glow("amber", C.bonus, 0.4, 0.4);
      D.blurIn("#b-k", C.moitie - 0.15);
      { const g = document.getElementById("pp"), P = [];
        for (let k = 0; k < 10; k++) { const u = document.createElementNS(NS, "use"); u.setAttribute("href", "#person"); u.setAttribute("x", 135 + k * 90); u.setAttribute("y", 1010);
          u.setAttribute("fill", k < 5 ? "#ffb21f" : "#3a3a44"); u.setAttribute("opacity", 0); g.appendChild(u); P.push(u); }
        tl.fromTo(P, { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.2, stagger: 0.04, ease: "back.out(2)" }, C.patients - 0.1); }
      tl.fromTo("#clk", { opacity: 0, scale: 0.7, transformOrigin: "300px 700px" }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2)" }, C.patients);
      { const arc = document.getElementById("arc"); const L = 2 * Math.PI * 170; arc.style.strokeDasharray = L; arc.style.strokeDashoffset = L;
        arc.setAttribute("d", "M300 530 A170 170 0 1 1 299.9 530");
        tl.to(arc, { strokeDashoffset: 0, duration: 1.2, ease: "power2.inOut" }, C.n3 - 0.2); }
      tl.fromTo("#hand", { rotation: 0, svgOrigin: "300 700" }, { rotation: 1080, svgOrigin: "300 700", duration: 1.2, ease: "power2.inOut" }, C.n3 - 0.2);
      tl.fromTo("#b-num", { opacity: 0, x: 40 }, { opacity: 1, x: 0, duration: 0.3, ease: "expo.out" }, C.n3 - 0.15);
      D.blurIn("#b-sub", C.heures);

      // ================= CHUTE : c'est juste ta part =================
      out(["#st3", "#b-k", "#clk", "#b-num", "#b-sub", "#ppl"], C.bref - 0.2);
      D.glow("amber", C.bref, 0.3, 0.4);
      D.blurIn("#bl-a", C.n23d - 0.2);
      tl.fromTo("#bar-a", { opacity: 0, scaleX: 0, transformOrigin: "0% 50%" }, { opacity: 1, scaleX: 1, duration: 0.35, ease: "power3.out" }, C.n23d - 0.15);
      D.blurIn("#bar-a-v", C.n23d);
      D.blurIn("#bl-b", C.n23d + 0.3);
      tl.fromTo("#bar-b", { opacity: 0, scaleX: 0, transformOrigin: "0% 50%" }, { opacity: 1, scaleX: 1, duration: 0.6, ease: "power3.out" }, C.n23d + 0.4);
      D.stamp("#e-stamp span", C.prix2 + 0.1, -5);
      D.shake(C.prix2 + 0.1, 9);
      D.glow("red", C.prix2 + 0.1, 0.4, 0.3);
      pulse("#e-stamp span", C.juste, 1.06);
      pulse("#bar-a", C.part2, 1.15);
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
