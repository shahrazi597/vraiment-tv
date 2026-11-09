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
      #pig { position: absolute; left: 0; top: 0; }
      #h-stamp { top: 1050px; }
      #h-stamp span { font-size: 74px; }

      /* ---------- étapes ---------- */
      .row { position: absolute; left: 0; right: 0; display: flex; justify-content: center; }
      .row .chip { position: absolute; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }
      #steps { top: 300px; height: 80px; }
      #infos { top: 392px; height: 80px; }

      /* étape 1 : la fiche de paie */
      #pay-k { position: absolute; left: 90px; top: 520px; font-size: 34px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); opacity: 0; }
      #pay-v { position: absolute; right: 90px; top: 500px; font-size: 64px; font-weight: 900; letter-spacing: -.04em; opacity: 0; white-space: nowrap; }
      #paybar { position: absolute; left: 90px; top: 590px; width: 900px; height: 130px; border-radius: 28px; border: 5px solid var(--cream);
        background: #111115; overflow: hidden; opacity: 0; }
      #pb-fill { position: absolute; left: 0; top: 0; bottom: 0; width: 100%; background: #2a2a32; }
      #pb-ret { position: absolute; right: 0; top: 0; bottom: 0; width: 28%; background: var(--amber); }
      #pb-lbl { position: absolute; right: 0; top: 0; bottom: 0; width: 28%; display: flex; align-items: center; justify-content: center;
        font-size: 64px; font-weight: 900; letter-spacing: -.04em; color: var(--ground); opacity: 0; white-space: nowrap; }
      #pb-note { position: absolute; right: 90px; top: 740px; font-size: 32px; font-weight: 800; color: var(--amber); letter-spacing: .04em; text-transform: uppercase; opacity: 0; }
      .acc { position: absolute; top: 820px; width: 430px; height: 260px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        text-align: center; opacity: 0; }
      .acc .k { margin-top: 38px; font-size: 34px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); }
      .acc .v { margin-top: 10px; font-size: 104px; font-weight: 900; letter-spacing: -.045em; line-height: 1.05; white-space: nowrap; }
      #ac-a { left: 90px; } #ac-a .v { color: var(--amber); }
      #ac-b { left: 560px; } #ac-b .v { color: var(--red); }

      #flow { position: absolute; left: 0; top: 0; }
      #rep-stamp { top: 1000px; }

      /* étape 3 : les droits */
      .dc { position: absolute; top: 560px; width: 430px; height: 400px; border-radius: 32px; background: var(--panel); border: 5px solid var(--line);
        text-align: center; opacity: 0; }
      .dc .k { margin-top: 36px; font-size: 38px; font-weight: 900; letter-spacing: .04em; text-transform: uppercase; }
      .dc .g { display: flex; flex-wrap: wrap; justify-content: center; gap: 18px; margin: 40px 50px 0; }
      #dc-a { left: 90px; } #dc-a .k { color: var(--amber); }
      #dc-b { left: 560px; } #dc-b .k { color: var(--cream); }
      .sq { width: 120px; height: 100px; border-radius: 18px; border: 5px solid var(--amber); opacity: 0; }
      .pt { width: 52px; height: 52px; border-radius: 50%; background: var(--cream); opacity: 0; }
      #fut { position: absolute; left: 140px; width: 800px; top: 1000px; height: 120px; border-radius: 30px; background: var(--panel); border: 4px solid var(--cold);
        display: flex; align-items: center; justify-content: center; gap: 22px; opacity: 0; font-size: 40px; font-weight: 900; text-transform: uppercase; letter-spacing: -.01em; white-space: nowrap; }
      #fut .ar { color: var(--cold); font-size: 60px; }

      /* le problème : le ratio */
      .big { position: absolute; top: 520px; width: 470px; text-align: center; opacity: 0; }
      .big .v { font-size: 130px; font-weight: 900; letter-spacing: -.05em; line-height: 1; white-space: nowrap; }
      .big .u { font-size: 40px; font-weight: 900; letter-spacing: -.01em; margin-top: 4px; white-space: nowrap; }
      .big .k { font-size: 32px; font-weight: 800; color: var(--muted); text-transform: uppercase; letter-spacing: .06em; margin-top: 10px; }
      #bg-a { left: 70px; } #bg-a .v, #bg-a .u { color: var(--amber); }
      #bg-b { left: 540px; } #bg-b .v, #bg-b .u { color: var(--cream); }
      #ppl { position: absolute; left: 0; top: 0; }
      #ratio { position: absolute; left: 0; right: 0; top: 1050px; text-align: center; font-size: 48px; font-weight: 900; text-transform: uppercase; letter-spacing: -.02em; opacity: 0; white-space: nowrap; }
      #ratio .a { color: var(--amber); }

      /* la facture */
      #f-k { position: absolute; left: 0; right: 0; top: 330px; text-align: center; font-size: 40px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); opacity: 0; }
      #f-num { position: absolute; left: 0; right: 0; top: 400px; text-align: center; font-size: 210px; font-weight: 900; letter-spacing: -.05em; color: var(--amber); line-height: 1; opacity: 0; white-space: nowrap; }
      #f-sub { position: absolute; left: 0; right: 0; top: 620px; text-align: center; font-size: 56px; font-weight: 900; text-transform: uppercase; opacity: 0; white-space: nowrap; }
      #coins { position: absolute; left: 0; right: 0; top: 740px; display: flex; justify-content: center; gap: 36px; }
      .cn { width: 190px; height: 190px; border-radius: 50%; border: 8px solid var(--cream); display: flex; align-items: center; justify-content: center;
        font-size: 96px; font-weight: 900; color: var(--cream); opacity: 0; background: #111115; }
      .cn.on { border-color: var(--amber); background: var(--amber); color: var(--ground); }
      #f-stamp { top: 990px; }
      #f-stamp span { font-size: 64px; }

      /* chute : le gâteau */
      #cake { position: absolute; left: 0; top: 0; }
      .cl { position: absolute; display: flex; justify-content: center; left: 0; right: 0; }
      .cl .chip { position: relative; font-size: 40px; padding: 18px 32px; gap: 16px; }
      .cl .chip b { width: 52px; height: 52px; font-size: 30px; }
      #cl1 { top: 830px; } #cl2 { top: 935px; } #cl3 { top: 1040px; }
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
          <div id="h-t1" class="hl">Tes cotisations<br />retraite&nbsp;?<br /><span class="a">Pas pour toi</span></div>
          <svg id="pig" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="piggy" transform="translate(0,60)">
              <text x="540" y="660" text-anchor="middle" font-family="Inter Display" font-weight="800" font-size="34" letter-spacing="2" fill="#8e8c95">MIS DE CÔTÉ POUR TOI ?</text>
              <ellipse cx="540" cy="840" rx="200" ry="140" fill="#16161b" stroke="#ece6d6" stroke-width="8" />
              <circle cx="720" cy="800" r="44" fill="#16161b" stroke="#ece6d6" stroke-width="8" />
              <circle cx="712" cy="800" r="7" fill="#ece6d6" /><circle cx="732" cy="800" r="7" fill="#ece6d6" />
              <path d="M410 735 l 20 -50 l 40 40" fill="#16161b" stroke="#ece6d6" stroke-width="8" stroke-linejoin="round" />
              <rect x="490" y="700" width="100" height="14" rx="7" fill="#ece6d6" />
              <g stroke="#ece6d6" stroke-width="10" stroke-linecap="round"><line x1="440" y1="965" x2="440" y2="1005" /><line x1="640" y1="965" x2="640" y2="1005" /></g>
              <path d="M340 830 q -40 -10 -30 -40" fill="none" stroke="#ece6d6" stroke-width="7" stroke-linecap="round" />
            </g>
            <g id="hcoin" opacity="0"><circle cx="540" cy="640" r="36" fill="#ffb21f" /><text x="540" y="655" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="46" fill="#0b0b0e">€</text></g>
            <g id="cross" stroke="#ff5236" stroke-width="22" stroke-linecap="round" opacity="0">
              <line id="cx1" x1="360" y1="760" x2="720" y2="1050" />
              <line id="cx2" x1="720" y1="760" x2="360" y2="1050" />
            </g>
          </svg>
          <div id="h-stamp" class="stamp"><span>Dépensé ce mois-ci&nbsp;!</span></div>
        </div>

        <!-- 2. Les étapes -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="steps" class="row">
            <div id="st1" class="chip amb"><b>1</b>TU COTISES</div>
            <div id="st2" class="chip"><b>2</b>ON VERSE AUSSITÔT</div>
            <div id="st3" class="chip cold"><b>3</b>TU GAGNES DES DROITS</div>
          </div>
          <div id="infos" class="row">
            <div id="in1" class="chip"><i style="background:var(--amber)"></i>Taux 2026, sous le plafond de la Sécu</div>
            <div id="in2" class="chip"><i style="background:var(--cream)"></i>Ça s'appelle la répartition</div>
            <div id="in3" class="chip"><i style="background:var(--cold)"></i>Pour calculer ta future pension</div>
          </div>

          <!-- étape 1 -->
          <div id="pay-k">Ton salaire brut</div>
          <div id="pay-v">100&nbsp;€</div>
          <div id="paybar"><div id="pb-fill"></div><div id="pb-ret"></div><div id="pb-lbl"><span id="v-28">0</span>&nbsp;€</div></div>
          <div id="pb-note">pour la retraite</div>
          <div id="ac-a" class="acc"><div class="k">Ta part</div><div class="v">11&nbsp;€</div></div>
          <div id="ac-b" class="acc"><div class="k">Ton patron</div><div class="v">17&nbsp;€</div></div>

          <!-- étape 2 -->
          <svg id="flow" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="nodes" font-family="Inter Display" font-weight="800" text-anchor="middle" letter-spacing="1" opacity="0">
              <g id="nd1"><circle cx="190" cy="780" r="105" fill="#16161b" stroke="#ffb21f" stroke-width="7" /><text x="190" y="772" fill="#f6f4ee" font-size="30">ACTIFS</text><text x="190" y="808" fill="#8e8c95" font-size="28">(TOI)</text></g>
              <g id="nd2"><circle cx="540" cy="780" r="105" fill="#16161b" stroke="#ece6d6" stroke-width="7" /><text x="540" y="772" fill="#f6f4ee" font-size="30">CAISSES</text><text x="540" y="808" fill="#8e8c95" font-size="28">RETRAITE</text></g>
              <g id="nd3"><circle cx="890" cy="780" r="105" fill="#16161b" stroke="#ece6d6" stroke-width="7" /><text x="890" y="790" fill="#f6f4ee" font-size="28">RETRAITÉS</text></g>
              <path id="ar1" d="M310 780 H420" stroke="#ece6d6" stroke-width="7" stroke-linecap="round" fill="none" opacity=".4" />
              <path id="ar2" d="M660 780 H770" stroke="#ece6d6" stroke-width="7" stroke-linecap="round" fill="none" opacity=".4" />
              <text id="same" x="540" y="960" fill="#ffb21f" font-size="40" font-weight="900" opacity="0">LE MÊME MOIS</text>
            </g>
            <g id="coin" opacity="0"><circle cx="190" cy="610" r="38" fill="#ffb21f" /><text x="190" y="625" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="44" fill="#0b0b0e">€</text></g>
          </svg>

          <!-- étape 3 -->
          <div id="dc-a" class="dc"><div class="k">Trimestres</div><div class="g"><div class="sq"></div><div class="sq"></div><div class="sq"></div><div class="sq"></div></div></div>
          <div id="dc-b" class="dc"><div class="k">Points</div><div class="g"><div class="pt"></div><div class="pt"></div><div class="pt"></div><div class="pt"></div><div class="pt"></div><div class="pt"></div><div class="pt"></div><div class="pt"></div><div class="pt"></div></div></div>
          <div id="fut"><span>Payée par les actifs de demain</span><span class="ar">→</span></div>

          <!-- le problème -->
          <div id="bg-a" class="big"><div class="v"><span id="v-304">0</span></div><div class="u">millions</div><div class="k">de cotisants</div></div>
          <div id="bg-b" class="big"><div class="v"><span id="v-172">0</span></div><div class="u">millions</div><div class="k">de retraités</div></div>
          <svg id="ppl" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <defs>
              <g id="person"><circle cx="0" cy="-58" r="22" /><path d="M-34 0 v-18 a34 30 0 0 1 68 0 v18 z" /></g>
            </defs>
            <g id="pa" fill="#ffb21f"></g>
            <g id="pb" fill="#ece6d6"></g>
            <line id="pdiv" x1="610" y1="870" x2="610" y2="1000" stroke="#2a2a32" stroke-width="5" opacity="0" />
          </svg>
          <div id="ratio"><span class="a">Moins de 2</span> actifs pour 1 retraité</div>

          <!-- la facture -->
          <div id="f-k">Les retraites en 2025</div>
          <div id="f-num"><span id="v-422">0</span>&nbsp;Md€</div>
          <div id="f-sub">de dépense publique</div>
          <div id="coins"><div class="cn">€</div><div class="cn">€</div><div class="cn">€</div><div class="cn">€</div></div>
          <div id="f-stamp" class="stamp"><span>Près d'1&nbsp;€ sur 4&nbsp;!</span></div>

          <!-- chute : le même gâteau -->
          <svg id="cake" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <text id="cake-t" x="540" y="380" text-anchor="middle" font-family="Inter Display" font-weight="900" font-size="88" letter-spacing="-2" fill="#f6f4ee" opacity="0">LE MÊME GÂTEAU</text>
            <g id="slices" stroke="#0b0b0e" stroke-width="10" stroke-linejoin="round">
              <path id="sl1" d="M540 620 L540 450 A170 170 0 0 1 687.2 705 Z" fill="#ffb21f" />
              <path id="sl2" d="M540 620 L687.2 705 A170 170 0 0 1 392.8 705 Z" fill="#ff5236" />
              <path id="sl3" d="M540 620 L392.8 705 A170 170 0 0 1 540 450 Z" fill="#ece6d6" />
            </g>
          </svg>
          <div id="cl1" class="cl"><span class="chip amb"><b>1</b>L'âge de départ</span></div>
          <div id="cl2" class="cl"><span class="chip hot"><b>2</b>Les cotisations</span></div>
          <div id="cl3" class="cl"><span class="chip"><b>3</b>Le montant des pensions</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Comment ça</div><div>marche</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 11 · La retraite par répartition</div>
          <div id="c-src">Sources : Cleiss (taux 2026) ; Insee et Drees (cotisants et retraités, 2023) ; COR, rapport annuel 2026</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMMENT ÇA MARCHE VRAIMENT&nbsp;?</span><span class="pill num">#11</span>
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

      // ================= 1. ACCROCHE =================
      D.glow("amber", 0, 0.4, 0.01);
      tl.to("#hcoin", { opacity: 1, duration: 0.1 }, C.cotises - 0.15);
      tl.fromTo("#hcoin", { y: -30 }, { y: 120, duration: 0.6, ease: "power2.in" }, C.cotises - 0.1);
      tl.to("#hcoin", { opacity: 0, duration: 0.08 }, C.cotises + 0.5);
      pulse("#piggy", C.cotises + 0.5, 1.04);
      { const a = document.getElementById("cx1"), b = document.getElementById("cx2");
        [a, b].forEach((l) => { const L = 470; l.style.strokeDasharray = L; l.style.strokeDashoffset = L; });
        tl.set("#cross", { opacity: 1 }, 0.01);
        tl.to(a, { strokeDashoffset: 0, duration: 0.18, ease: "power2.out" }, C.pas - 0.1);
        tl.to(b, { strokeDashoffset: 0, duration: 0.18, ease: "power2.out" }, C.pas + 0.08); }
      pulse("#h-t1 .a", C.toi - 0.05, 1.1);
      D.glow("red", C.pas, 0.3, 0.3);
      tl.to("#pig", { opacity: 0.35, duration: 0.25 }, C.depense - 0.15);
      D.stamp("#h-stamp span", C.depense - 0.05, -5);
      D.shake(C.depense, 11);
      D.flash(C.depense, 0.16);
      D.glow("red", C.depense, 0.55, 0.3); D.glow("amber", C.depense, 0.1, 0.4);
      pulse("#h-stamp span", C.moisci, 1.06);
      const T1 = C.comment;
      D.blurOut(["#h-t1", "#h-stamp span"], T1 + 0.35, 0.16);
      tl.to("#pig", { opacity: 0, scale: 1.15, filter: "blur(10px)", transformOrigin: "540px 900px", duration: 0.3, ease: "power3.in" }, T1 + 0.3);
      D.glow("red", T1, 0.1, 0.4); D.glow("cream", T1, 0.25, 0.4);

      const step = (n, t) => { if (n > 1) D.blurOut("#st" + (n - 1), t - 0.12, 0.12); D.popIn("#st" + n, t, 0.6); };

      // ================= ÉTAPE 1 : tu cotises =================
      step(1, C.e1);
      D.blurIn(["#pay-k", "#pay-v"], C.salaire - 0.1);
      tl.fromTo("#paybar", { opacity: 0, scaleX: 0.2, transformOrigin: "0% 50%" }, { opacity: 1, scaleX: 1, duration: 0.4, ease: "expo.out" }, C.salaire);
      pulse("#pay-v", C.n100, 1.12);
      tl.fromTo("#pb-ret", { scaleX: 0, transformOrigin: "100% 50%" }, { scaleX: 1, duration: 0.45, ease: "power3.out", immediateRender: true }, C.n28 - 0.15);
      tl.to("#pb-lbl", { opacity: 1, duration: 0.2 }, C.n28 - 0.05);
      D.count("v-28", 0, 28, C.n28 - 0.1, 0.6, 0);
      D.blurIn("#pb-note", C.n28 + 0.3);
      D.glow("amber", C.n28, 0.5, 0.4); D.glow("cream", C.n28, 0.1, 0.4);
      D.popIn("#in1", C.n28 + 0.5, 0.6);
      tl.fromTo("#ac-a", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.n11 - 0.15);
      tl.fromTo("#ac-b", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.n17 - 0.15);
      tl.to("#ac-b", { borderColor: "#ff5236", duration: 0.2 }, C.patron);
      tl.to("#ac-a", { borderColor: "#ffb21f", duration: 0.2 }, C.n11);

      // ================= ÉTAPE 2 : versé aussitôt =================
      step(2, C.e2);
      out(["#in1", "#pay-k", "#pay-v", "#paybar", "#pb-note", "#ac-a", "#ac-b"], C.e2 - 0.15);
      D.glow("amber", C.e2, 0.25, 0.4);
      tl.to("#nodes", { opacity: 1, duration: 0.3 }, C.e2 + 0.1);
      tl.fromTo(["#nd1", "#nd2", "#nd3"], { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, stagger: 0.12, ease: "expo.out" }, C.e2 + 0.1);
      tl.to("#coin", { opacity: 1, duration: 0.15 }, C.caisses - 0.2);
      tl.to("#coin", { x: 350, duration: 0.5, ease: "power2.inOut" }, C.caisses);
      tl.to("#ar1", { opacity: 1, stroke: "#ffb21f", duration: 0.25 }, C.caisses + 0.1);
      pulse("#nd2", C.argent, 1.06);
      tl.to("#coin", { x: 700, duration: 0.3, ease: "power3.in" }, C.versent - 0.05);
      tl.to("#ar2", { opacity: 1, stroke: "#ffb21f", duration: 0.2 }, C.versent);
      tl.to("#nd3 circle", { stroke: "#ffb21f", duration: 0.2 }, C.aussitot);
      pulse("#nd3", C.aussitot, 1.08);
      tl.to("#same", { opacity: 1, duration: 0.25 }, C.retraites - 0.1);
      D.glow("amber", C.aussitot, 0.5, 0.3);
      D.popIn("#in2", C.aussitot + 0.3, 0.5);

      // ================= ÉTAPE 3 : les droits =================
      step(3, C.e3);
      D.blurOut("#in2", C.e3 - 0.15, 0.12);
      out(["#nodes", "#coin"], C.e3 - 0.15);
      D.glow("amber", C.e3, 0.15, 0.4); D.glow("cold", C.e3, 0.3, 0.4);
      tl.fromTo("#dc-a", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.e3 + 0.35);
      tl.fromTo("#dc-b", { opacity: 0, y: 50 }, { opacity: 1, y: 0, duration: 0.35, ease: "back.out(1.8)" }, C.e3 + 0.45);
      tl.fromTo("#dc-a .sq", { opacity: 0, scale: 0.4 }, { opacity: 1, scale: 1, duration: 0.25, stagger: 0.1, ease: "back.out(2.5)" }, C.trimestres - 0.1);
      tl.to("#dc-a .sq", { backgroundColor: "#ffb21f", duration: 0.12, stagger: 0.1 }, C.trimestres + 0.2);
      tl.fromTo("#dc-b .pt", { opacity: 0, scale: 0.3 }, { opacity: 1, scale: 1, duration: 0.22, stagger: 0.05, ease: "back.out(2.5)" }, C.points - 0.1);
      D.popIn("#in3", C.calculer - 0.2, 0.5);
      tl.fromTo("#fut", { opacity: 0, x: -80 }, { opacity: 1, x: 0, duration: 0.35, ease: "expo.out" }, C.pension - 0.1);
      tl.fromTo("#fut .ar", { x: -10 }, { x: 14, duration: 0.5, repeat: 1, yoyo: true, ease: "sine.inOut" }, C.demain);
      D.glow("cold", C.demain, 0.5, 0.4);

      // ================= LE PROBLÈME : le ratio =================
      out(["#st3", "#in3", "#dc-a", "#dc-b", "#fut"], C.probleme - 0.2);
      D.glow("cold", C.probleme, 0, 0.4); D.glow("amber", C.probleme, 0.3, 0.4);
      tl.fromTo("#bg-a", { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 0.3, ease: "expo.out" }, C.n304 - 0.2);
      D.count("v-304", 0, 30.4, C.n304 - 0.15, 1.0, 1);
      tl.fromTo("#bg-b", { opacity: 0, y: 40 }, { opacity: 1, y: 0, duration: 0.3, ease: "expo.out" }, C.n172 - 0.2);
      D.count("v-172", 0, 17.2, C.n172 - 0.15, 1.0, 1);
      { const pa = document.getElementById("pa"), pb = document.getElementById("pb"), P = [];
        const mk = (g, x, y) => { const u = document.createElementNS(NS, "use"); u.setAttribute("href", "#person"); u.setAttribute("x", x); u.setAttribute("y", y); u.setAttribute("opacity", 0); u.setAttribute("fill", "#3a3a44"); g.appendChild(u); return u; };
        const A = [], B = [];
        for (let k = 0; k < 7; k++) A.push(mk(pa, 115 + k * 70, 990));
        for (let k = 0; k < 4; k++) B.push(mk(pb, 700 + k * 80, 990));
        tl.fromTo(A.concat(B), { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.2, stagger: 0.04, ease: "back.out(2)" }, C.probleme + 0.1);
        tl.to(A, { attr: { fill: "#ffb21f" }, duration: 0.12, stagger: 0.05 }, C.cotisants - 0.1);
        tl.to(B, { attr: { fill: "#ece6d6" }, duration: 0.12, stagger: 0.07 }, C.retraites2 - 0.1);
        tl.to("#pdiv", { opacity: 1, duration: 0.2 }, C.retraites2); }
      tl.fromTo("#ratio", { opacity: 0, scale: 0.8 }, { opacity: 1, scale: 1, duration: 0.3, ease: "back.out(2)" }, C.moins - 0.1);
      D.shake(C.moins, 8);
      D.glow("red", C.moins, 0.35, 0.3);

      // ================= LA FACTURE =================
      out(["#bg-a", "#bg-b", "#ppl", "#ratio"], C.facture - 0.3);
      D.glow("red", C.facture, 0.1, 0.4); D.glow("amber", C.facture, 0.45, 0.4);
      D.blurIn("#f-k", C.facture - 0.1);
      tl.fromTo("#f-num", { opacity: 0, scale: 0.7 }, { opacity: 1, scale: 1, duration: 0.35, ease: "back.out(2)" }, C.n422 - 0.2);
      D.count("v-422", 0, 422, C.n422 - 0.2, 1.1, 0);
      D.blurIn("#f-sub", C.pres - 0.3);
      tl.fromTo(".cn", { opacity: 0, scale: 0.5 }, { opacity: 1, scale: 1, duration: 0.3, stagger: 0.08, ease: "back.out(2)" }, C.pres - 0.1);
      tl.to(".cn:first-child", { borderColor: "#ffb21f", backgroundColor: "#ffb21f", color: "#0b0b0e", duration: 0.15 }, C.pres + 0.35);
      D.stamp("#f-stamp span", C.pres + 0.1, -4);
      D.flash(C.pres + 0.1, 0.14, "#ffb21f");
      pulse("#f-stamp span", C.n4, 1.06);

      // ================= CHUTE : le même gâteau =================
      out(["#f-k", "#f-num", "#f-sub", "#coins", "#f-stamp span"], C.voila - 0.15);
      D.glow("amber", C.voila, 0.3, 0.4);
      tl.fromTo("#slices path", { opacity: 0, scale: 0.6, transformOrigin: "540px 620px" }, { opacity: 1, scale: 1, duration: 0.35, stagger: 0.1, ease: "back.out(2)" }, C.voila);
      D.popIn("#cl1 .chip", C.lage - 0.1, 0.5);
      tl.to("#sl1", { x: -18, y: -12, duration: 0.25, ease: "back.out(2)" }, C.lage);
      D.popIn("#cl2 .chip", C.cotisations - 0.1, 0.5);
      tl.to("#sl2", { y: 20, duration: 0.25, ease: "back.out(2)" }, C.cotisations);
      D.popIn("#cl3 .chip", C.montant - 0.1, 0.5);
      tl.to("#sl3", { x: 18, y: -12, duration: 0.25, ease: "back.out(2)" }, C.montant);
      tl.fromTo("#cake-t", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3 }, C.voila + 0.2);
      pulse("#cake-t", C.gateau, 1.06);
      tl.to("#slices path", { x: 0, y: 0, duration: 0.3, ease: "power3.inOut" }, C.gateau);
      D.glow("red", C.gateau, 0.2, 0.4);
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
