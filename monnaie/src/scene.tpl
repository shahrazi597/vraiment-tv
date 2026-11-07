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
      #h-t1 { top: 300px; font-size: 100px; }
      #vault { position: absolute; left: 0; top: 0; }
      #h-stamp { top: 1060px; }

      /* ---------- étapes ---------- */
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 300px; height: 80px; }
      #infos { top: 392px; height: 80px; }

      .acc { position: absolute; top: 520px; width: 430px; height: 290px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        text-align: center; opacity: 0; }
      .acc .k { margin-top: 40px; font-size: 34px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); }
      .acc .v { margin-top: 12px; font-size: 80px; font-weight: 900; letter-spacing: -.045em; line-height: 1.05; white-space: nowrap; }
      .acc .s { font-size: 30px; font-weight: 700; color: var(--muted); margin-top: 6px; }
      #ac-a { left: 90px; } #ac-a .v { color: var(--amber); }
      #ac-b { left: 560px; } #ac-b .v { color: var(--red); }
      #quote { position: absolute; left: 90px; right: 90px; top: 870px; text-align: center; opacity: 0; }
      #quote .q { font-size: 64px; font-weight: 900; letter-spacing: -.03em; line-height: 1.05; color: var(--ink); }
      #quote .q .a { color: var(--amber); }
      #quote .w { margin-top: 14px; font-size: 32px; font-weight: 800; color: var(--muted); letter-spacing: .04em; text-transform: uppercase; }

      #flow { position: absolute; left: 0; top: 0; }

      #lim-t { top: 420px; font-size: 92px; }
      #lim-t .wsp { opacity: 0; }
      .lim { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .lim .chip { position: relative; font-size: 42px; padding: 20px 34px; gap: 18px; }
      .lim .chip b { width: 56px; height: 56px; font-size: 32px; }
      #lm1 { top: 650px; } #lm2 { top: 780px; } #lm3 { top: 910px; }

      /* ---------- bonus : 90 % ---------- */
      #b-num { position: absolute; left: 0; right: 0; top: 330px; text-align: center; font-size: 200px; font-weight: 900; letter-spacing: -.05em;
        color: var(--amber); line-height: 1; opacity: 0; white-space: nowrap; }
      #b-sub { position: absolute; left: 0; right: 0; top: 545px; text-align: center; font-size: 42px; font-weight: 800; color: var(--muted); opacity: 0; }
      #cells { position: absolute; left: 90px; top: 660px; width: 900px; height: 200px; display: flex; gap: 10px; }
      #cells .cl { flex: 1; border-radius: 16px; background: #2a2a32; opacity: 0; display: flex; align-items: center; justify-content: center;
        font-size: 30px; font-weight: 900; color: rgba(11,11,14,.8); writing-mode: vertical-rl; transform: rotate(180deg); letter-spacing: .04em; }
      #cells .cl.bill { background: #ece6d6; }
      .cap2 { position: absolute; top: 890px; opacity: 0; white-space: nowrap; }
      .cap2 .v { font-size: 56px; font-weight: 900; letter-spacing: -.03em; line-height: 1; }
      .cap2 .s { font-size: 30px; font-weight: 700; color: var(--muted); margin-top: 6px; }
      #cp-a { left: 90px; } #cp-a .v { color: var(--cream); }
      #cp-b { right: 90px; text-align: right; } #cp-b .v { color: var(--amber); }

      /* ---------- chute : la BCE ---------- */
      .ch { position: absolute; left: 140px; width: 800px; height: 150px; border-radius: 30px; background: var(--panel); border: 4px solid var(--line);
        display: flex; align-items: center; gap: 30px; padding: 0 40px; opacity: 0; }
      .ch .ar { font-size: 92px; font-weight: 900; line-height: 1; width: 70px; text-align: center; }
      .ch .t { font-size: 50px; font-weight: 900; letter-spacing: -.02em; text-transform: uppercase; line-height: 1.02; white-space: nowrap; }
      #ch1 { top: 380px; border-color: var(--red); } #ch1 .ar { color: var(--red); }
      #ch2 { top: 610px; border-color: var(--red); } #ch2 .ar { color: var(--red); }
      #ch3 { top: 840px; border-color: var(--cold); } #ch3 .ar { color: var(--cold); }
      #chain { position: absolute; left: 0; top: 0; }
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
          <div id="h-t1" class="hl">Ta banque<br />te prête<br /><span class="a">10&nbsp;000&nbsp;€</span></div>
          <svg id="vault" width="1080" height="1920" viewBox="0 -70 1080 1920" aria-hidden="true">
            <g id="safe">
              <rect x="350" y="650" width="380" height="320" rx="30" fill="#16161b" stroke="#ece6d6" stroke-width="7" />
              <circle cx="540" cy="810" r="86" fill="none" stroke="#ece6d6" stroke-width="7" />
              <circle cx="540" cy="810" r="16" fill="#ece6d6" />
              <g stroke="#ece6d6" stroke-width="7" stroke-linecap="round"><line x1="540" y1="740" x2="540" y2="770" /><line x1="540" y1="850" x2="540" y2="880" /><line x1="470" y1="810" x2="500" y2="810" /><line x1="580" y1="810" x2="610" y2="810" /></g>
              <rect x="390" y="970" width="60" height="22" rx="6" fill="#ece6d6" /><rect x="630" y="970" width="60" height="22" rx="6" fill="#ece6d6" />
              <text x="540" y="630" text-anchor="middle" font-family="Inter Display" font-weight="800" font-size="34" letter-spacing="2" fill="#8e8c95">L'ARGENT DES AUTRES CLIENTS</text>
            </g>
            <g id="cross" stroke="#ff5236" stroke-width="22" stroke-linecap="round">
              <line id="cx1" x1="380" y1="670" x2="700" y2="960" />
              <line id="cx2" x1="700" y1="670" x2="380" y2="960" />
            </g>
          </svg>
          <div id="h-stamp" class="stamp"><span>Elle le crée&nbsp;!</span></div>
        </div>

        <!-- 2. Les étapes -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="steps" class="row">
            <div id="st1" class="chip amb"><b>1</b>LE CRÉDIT</div>
            <div id="st2" class="chip"><b>2</b>LA DÉPENSE</div>
            <div id="st3" class="chip hot"><b>3</b>LE REMBOURSEMENT</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--amber)"></i>Ces euros n'existaient pas avant</div>
            <div id="in2" class="chip"><i style="background:var(--cream)"></i>Il circule de compte en compte</div>
            <div id="in3" class="chip"><i style="background:var(--amber)"></i>Les intérêts : pour la banque</div>
          </div>

          <div id="ac-a" class="acc"><div class="k">Ton compte</div><div class="v">+<span id="v-acc">0</span>&nbsp;€</div><div class="s">ce que tu peux dépenser</div></div>
          <div id="ac-b" class="acc"><div class="k">Ta dette</div><div class="v"><span id="v-debt">0</span>&nbsp;€</div><div class="s">ce que tu dois rendre</div></div>
          <div id="quote"><div class="q">«&nbsp;Les <span class="a">crédits</span> font<br />les <span class="a">dépôts</span>&nbsp;»</div><div class="w">— Banque de France</div></div>

          <svg id="flow" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="nodes" font-family="Inter Display" font-weight="800" font-size="30" text-anchor="middle" letter-spacing="1">
              <g id="nd1"><circle cx="190" cy="1010" r="78" fill="#16161b" stroke="#ffb21f" stroke-width="6" /><text x="190" y="1021" fill="#f6f4ee">TOI</text></g>
              <g id="nd2"><circle cx="540" cy="1010" r="78" fill="#16161b" stroke="#ece6d6" stroke-width="6" /><text x="540" y="1021" fill="#f6f4ee" font-size="26">VENDEUR</text></g>
              <g id="nd3"><circle cx="890" cy="1010" r="78" fill="#16161b" stroke="#ece6d6" stroke-width="6" /><text x="890" y="1003" fill="#f6f4ee" font-size="24">FOURNIS-</text><text x="890" y="1033" fill="#f6f4ee" font-size="24">SEURS</text></g>
              <path id="ar1" d="M285 1010 H435" stroke="#ece6d6" stroke-width="6" stroke-linecap="round" fill="none" opacity=".5" />
              <path id="ar2" d="M635 1010 H785" stroke="#ece6d6" stroke-width="6" stroke-linecap="round" fill="none" opacity=".5" />
            </g>
            <g id="coin"><circle cx="190" cy="890" r="34" fill="#ffb21f" /><text x="190" y="904" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="40" fill="#0b0b0e">€</text></g>
            <g id="dust" fill="#ffb21f"></g>
          </svg>
          <div id="d-stamp" class="stamp" style="top: 870px"><span>Détruit&nbsp;!</span></div>

          <div id="lim-t" class="hl"><span class="wsp">Pas</span> <span class="wsp">à</span> <span class="wsp r">l'infini</span></div>
          <div id="lm1" class="lim"><span class="chip amb"><b>1</b>Des fonds propres</span></div>
          <div id="lm2" class="lim"><span class="chip cold"><b>2</b>Des réserves à la banque centrale</span></div>
          <div id="lm3" class="lim"><span class="chip hot"><b>3</b>Vérifier que tu peux rembourser</span></div>

          <!-- bonus -->
          <div id="b-num"><span style="font-size:80px;letter-spacing:-.02em">PLUS DE </span><span id="v-90">0</span>&nbsp;%</div>
          <div id="b-sub">des euros en circulation</div>
          <div id="cells">
            <div class="cl bill">BILLETS</div><div class="cl"></div><div class="cl"></div><div class="cl"></div><div class="cl"></div>
            <div class="cl"></div><div class="cl"></div><div class="cl"></div><div class="cl"></div><div class="cl"></div>
          </div>
          <div id="cp-a" class="cap2"><div class="v">Billets et pièces</div><div class="s">moins de 10&nbsp;%</div></div>
          <div id="cp-b" class="cap2"><div class="v">Sur des comptes</div><div class="s">juste des chiffres</div></div>

          <!-- chute -->
          <svg id="chain" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <path id="lk1" d="M540 540 V600" stroke="#8e8c95" stroke-width="6" stroke-linecap="round" opacity="0" />
            <path id="lk2" d="M540 770 V830" stroke="#8e8c95" stroke-width="6" stroke-linecap="round" opacity="0" />
          </svg>
          <div id="ch1" class="ch"><div class="ar">↑</div><div class="t">Les taux de la BCE</div></div>
          <div id="ch2" class="ch"><div class="ar">↑</div><div class="t">Ton crédit coûte<br />plus cher</div></div>
          <div id="ch3" class="ch"><div class="ar">↓</div><div class="t">Moins d'argent créé</div></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 8 · La création monétaire</div>
          <div id="c-src">Sources : Banque de France, « Comment est créée la monnaie ? » et « La monnaie »</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#8</span>
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
      const sp = (v) => Math.round(v).toLocaleString("fr-FR").replace(/ | |,/g, " ");
      const countInt = (id, a, b, at, d) => { const o = { v: a }, el = document.getElementById(id);
        tl.to(o, { v: b, duration: d, ease: "power2.out", onUpdate: () => (el.textContent = sp(o.v)) }, at); };
      const pulse = (sel, at, s = 1.08) => tl.fromTo(sel, { scale: 1 }, { keyframes: [{ scale: s, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, at);
      let seed = 7; const rnd = () => ((seed = (seed * 16807) % 2147483647) / 2147483647);

      // ================= 1. ACCROCHE =================
      D.glow("amber", 0, 0.45, 0.01);
      pulse("#h-t1 .a", C.n10k - 0.05, 1.1);
      tl.fromTo("#safe", { opacity: 0.7 }, { opacity: 1, duration: 0.3 }, C.prend - 0.2);
      { const a = document.getElementById("cx1"), b = document.getElementById("cx2");
        [a, b].forEach((l) => { const L = 440; l.style.strokeDasharray = L; l.style.strokeDashoffset = L; });
        tl.set("#cross", { opacity: 1 }, 0);
        tl.to(a, { strokeDashoffset: 0, duration: 0.18, ease: "power2.out" }, C.clients - 0.1);
        tl.to(b, { strokeDashoffset: 0, duration: 0.18, ease: "power2.out" }, C.clients + 0.08); }
      D.glow("red", C.clients, 0.3, 0.3);
      tl.to("#vault", { opacity: 0.35, duration: 0.25 }, C.cree - 0.15);
      D.stamp("#h-stamp span", C.cree - 0.05, -5);
      D.shake(C.cree, 11);
      D.flash(C.cree, 0.16, "#ffb21f");
      D.glow("amber", C.cree, 0.6, 0.3); D.glow("red", C.cree, 0.1, 0.4);
      const T1 = C.comment;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 + 0.35, 0.16);
      tl.to("#vault", { opacity: 0, scale: 1.15, filter: "blur(10px)", transformOrigin: "540px 800px", duration: 0.3, ease: "power3.in" }, T1 + 0.3);
      D.glow("amber", T1, 0.25, 0.4); D.glow("cream", T1, 0.25, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.12, 0.12); D.popIn("#st" + n, t, 0.6); };
      tl.set(["#nodes", "#coin"], { opacity: 0 }, 0);

      // ================= ÉTAPE 1 : le crédit crée l'argent =================
      step(1, C.e1);
      tl.fromTo("#ac-b", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.credit - 0.15);
      countInt("v-debt", 0, 10000, C.credit, 0.8);
      tl.fromTo("#ac-a", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.tape - 0.2);
      countInt("v-acc", 0, 10000, C.n10k2 - 0.1, 1.0);
      tl.to("#ac-a", { borderColor: "#ffb21f", duration: 0.25 }, C.n10k2);
      D.glow("amber", C.n10k2, 0.55, 0.4);
      D.popIn("#in1", C.nexistaient - 0.1, 0.5);
      pulse("#ac-a", C.seconde, 1.05);
      tl.fromTo("#quote", { opacity: 0, y: 30, filter: "blur(10px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.3, ease: "expo.out" }, C.credits - 0.15);
      pulse("#quote .q", C.depots, 1.05);

      // ================= ÉTAPE 2 : l'argent circule =================
      step(2, C.e2);
      D.blurOut("#in1", C.e2 - 0.15, 0.12);
      tl.to(["#ac-b", "#quote"], { opacity: 0, filter: "blur(10px)", duration: 0.25 }, C.e2 - 0.15);
      tl.to("#ac-a", { x: 225, duration: 0.45, ease: "power3.inOut" }, C.e2);
      tl.to("#nodes", { opacity: 1, duration: 0.3 }, C.achetes - 0.1);
      tl.fromTo(["#nd1", "#nd2", "#nd3"], { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, stagger: 0.08, ease: "expo.out" }, C.achetes - 0.1);
      tl.to("#coin", { opacity: 1, duration: 0.15 }, C.voiture - 0.1);
      tl.to("#coin", { x: 350, duration: 0.5, ease: "power2.inOut" }, C.part - 0.05);
      tl.to("#ar1", { opacity: 1, stroke: "#ffb21f", duration: 0.25 }, C.part);
      tl.to("#ac-a", { opacity: 0.35, duration: 0.3 }, C.vendeur - 0.1);
      tl.to("#coin", { x: 700, duration: 0.5, ease: "power2.inOut" }, C.fournisseurs - 0.15);
      tl.to("#ar2", { opacity: 1, stroke: "#ffb21f", duration: 0.25 }, C.fournisseurs - 0.1);
      D.popIn("#in2", C.circule - 0.1, 0.5);
      tl.to("#coin", { x: 0, duration: 0.6, ease: "power2.inOut" }, C.circule + 0.2);

      // ================= ÉTAPE 3 : le remboursement détruit l'argent =================
      step(3, C.e3);
      D.blurOut("#in2", C.e3 - 0.15, 0.12);
      tl.to(["#nodes", "#ac-a"], { opacity: 0, filter: "blur(8px)", duration: 0.25 }, C.e3 - 0.15);
      tl.set("#ac-a", { x: 0, filter: "blur(0px)" }, C.e3 + 0.15);
      tl.to("#ac-a", { opacity: 1, duration: 0.3 }, C.e3 + 0.15);
      tl.to("#ac-b", { opacity: 1, filter: "blur(0px)", duration: 0.3 }, C.e3 + 0.15);
      tl.to("#coin", { opacity: 0, duration: 0.2 }, C.e3 - 0.1);
      countInt("v-acc", 10000, 0, C.rembourses, 0.9);
      countInt("v-debt", 10000, 0, C.rembourses, 0.9);
      { const dg = document.getElementById("dust"), P = [];
        for (let k = 0; k < 46; k++) { const c = document.createElementNS(NS, "circle");
          c.setAttribute("cx", 120 + rnd() * 840); c.setAttribute("cy", 560 + rnd() * 220); c.setAttribute("r", 5 + rnd() * 9); c.setAttribute("opacity", 0); dg.appendChild(c); P.push(c); }
        P.forEach((c, k) => tl.fromTo(c, { opacity: 0, y: 0 }, { keyframes: [{ opacity: 0.9, duration: 0.08 }, { opacity: 0, y: -120 - rnd() * 160, duration: 0.9, ease: "power2.out" }] }, C.detruit - 0.05 + (k % 9) * 0.03)); }
      tl.to(["#ac-a", "#ac-b"], { opacity: 0.25, scale: 0.92, duration: 0.3 }, C.detruit);
      D.stamp("#d-stamp span", C.detruit, -5);
      D.shake(C.detruit + 0.02, 12);
      D.flash(C.detruit + 0.02, 0.16);
      D.glow("red", C.detruit, 0.45, 0.3); D.glow("amber", C.detruit, 0.1, 0.4);
      D.popIn("#in3", C.interets - 0.1, 0.5);
      D.glow("amber", C.interets, 0.4, 0.4); D.glow("red", C.interets, 0.1, 0.4);

      // ================= LES LIMITES =================
      D.blurOut(["#st3", "#in3", "#d-stamp span", "#ac-a", "#ac-b"], C.mais - 0.2, 0.15);
      tl.fromTo("#lim-t .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.08, ease: "power2.out" }, C.pas2 - 0.1);
      D.glow("red", C.infini, 0.35, 0.4); D.glow("amber", C.infini, 0.15, 0.4);
      D.popIn("#lm1 .chip", C.fonds - 0.1, 0.5);
      D.popIn("#lm2 .chip", C.reserves - 0.1, 0.5);
      D.glow("cold", C.reserves, 0.35, 0.4);
      D.popIn("#lm3 .chip", C.verifier - 0.1, 0.5);

      // ================= BONUS : plus de 90 % =================
      tl.to(["#lim-t", ".lim"], { opacity: 0, filter: "blur(10px)", duration: 0.25 }, C.fou - 0.35);
      D.glow("red", C.fou, 0, 0.4); D.glow("cold", C.fou, 0, 0.4); D.glow("amber", C.fou, 0.45, 0.4);
      tl.fromTo("#b-num", { opacity: 0, scale: 0.7 }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2)" }, C.n90 - 0.2);
      countInt("v-90", 50, 90, C.n90 - 0.2, 0.7);
      D.blurIn("#b-sub", C.circulation - 0.1);
      tl.to("#cells .cl", { opacity: 1, duration: 0.2, stagger: 0.04 }, C.circulation);
      tl.fromTo("#cells .bill", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.1 }, { scale: 1, duration: 0.3 }] }, C.billets - 0.05);
      D.blurIn("#cp-a", C.billets - 0.1);
      tl.to("#cells .cl:not(.bill)", { backgroundColor: "#ffb21f", duration: 0.1, stagger: 0.04 }, C.chiffres - 0.15);
      D.blurIn("#cp-b", C.chiffres - 0.3);
      D.flash(C.comptes, 0.12, "#ffb21f");

      // ================= CHUTE : la BCE =================
      tl.to(["#b-num", "#b-sub", "#cells", ".cap2"], { opacity: 0, filter: "blur(10px)", duration: 0.25 }, C.alors - 0.1);
      D.glow("amber", C.alors, 0.1, 0.4); D.glow("red", C.alors, 0.3, 0.4);
      tl.fromTo("#ch1", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.bce - 0.15);
      tl.fromTo("#ch1 .ar", { y: 30 }, { y: 0, duration: 0.4, ease: "back.out(3)" }, C.monte - 0.05);
      tl.to("#lk1", { opacity: 1, duration: 0.2 }, C.credit3 - 0.2);
      tl.fromTo("#ch2", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.credit3 - 0.1);
      tl.fromTo("#ch2 .ar", { y: 30 }, { y: 0, duration: 0.4, ease: "back.out(3)" }, C.cher - 0.1);
      tl.to("#lk2", { opacity: 1, duration: 0.2 }, C.expres);
      tl.fromTo("#ch3", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.freiner - 0.15);
      tl.fromTo("#ch3 .ar", { y: -30 }, { y: 0, duration: 0.4, ease: "back.out(3)" }, C.freiner);
      D.glow("cold", C.freiner, 0.45, 0.4); D.glow("red", C.freiner, 0.1, 0.4);
      D.shake(C.creation, 7);
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
