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
      #h-t1 { top: 330px; font-size: 100px; }
      #h-price { position: absolute; left: 0; right: 0; top: 600px; text-align: center; font-size: 250px; font-weight: 900;
        letter-spacing: -.05em; line-height: 1; color: var(--amber); white-space: nowrap; }
      #h-stamp { top: 975px; }
      #h-kick { position: absolute; left: 0; right: 0; top: 885px; text-align: center; font-size: 46px; font-weight: 800; color: var(--cream); opacity: 0; }

      /* ---------- le paquet ---------- */
      #ptag { position: absolute; left: 90px; top: 318px; width: 330px; height: 112px; border-radius: 28px; background: var(--panel);
        border: 3px solid var(--line); display: flex; align-items: center; justify-content: center; opacity: 0;
        font-size: 72px; font-weight: 900; letter-spacing: -.04em; color: var(--amber); white-space: nowrap; }
      #tips { position: absolute; left: 112px; top: 448px; width: 286px; height: 40px; opacity: 0; }
      #pack { position: absolute; left: 90px; top: 470px; width: 330px; height: 660px; border-radius: 36px;
        border: 5px solid var(--cream); background: #111115; overflow: hidden; opacity: 0; }
      #lid { position: absolute; left: 0; right: 0; top: 0; height: 120px; border-bottom: 4px solid rgba(236,230,214,.35); z-index: 6; }
      .layer { position: absolute; left: 0; width: 320px; }
      #ly-acc { bottom: 0; height: 422px; z-index: 4; background: linear-gradient(180deg, #ff6c4e, #e43a1f); }
      #ly-tva { bottom: 422px; height: 107px; z-index: 3; background: linear-gradient(180deg, #ffc451, #f39a00); }
      #ly-bur { bottom: 529px; height: 66px; z-index: 2; background: linear-gradient(180deg, #f4efe2, #d8d0bb); }
      #ly-fab { bottom: 595px; height: 46px; z-index: 1; background: linear-gradient(180deg, #7fd6ff, #2ea9e8); }
      .pct { position: absolute; left: 0; right: 0; top: 50%; margin-top: -32px; text-align: center; font-size: 58px; font-weight: 900;
        letter-spacing: -.03em; color: rgba(11,11,14,.85); opacity: 0; }
      #ly-tva .pct { font-size: 50px; margin-top: -28px; }

      .label { position: absolute; left: 470px; width: 540px; opacity: 0; }
      .label .name { display: flex; align-items: center; gap: 14px; font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; white-space: nowrap; }
      .label .name i { display: block; width: 22px; height: 22px; border-radius: 6px; }
      .label .sub { font-size: 30px; font-weight: 600; color: var(--muted); margin-top: 4px; }
      .label .val { font-size: 84px; font-weight: 900; letter-spacing: -.045em; line-height: 1.04; margin-top: 2px; white-space: nowrap; opacity: 0; }
      #l-fab { top: 300px; }  #l-fab .val { color: var(--cold); }
      #l-bur { top: 440px; }  #l-bur .val { color: var(--cream); }
      #l-tva { top: 580px; }  #l-tva .val { color: var(--amber); }
      #l-acc { top: 730px; }  #l-acc .val { color: var(--red); font-size: 100px; }
      .chips { position: absolute; left: 470px; width: 560px; display: flex; flex-wrap: wrap; gap: 12px; }
      .chips .chip { position: relative; font-size: 30px; padding: 10px 20px; }
      #ch-acc { top: 930px; }
      #ch-fab { top: 1010px; }

      /* ---------- bilan ---------- */
      #b-title { position: absolute; top: 300px; left: 0; right: 0; text-align: center; font-size: 160px; font-weight: 900;
        letter-spacing: -.05em; line-height: 1; text-transform: uppercase; white-space: nowrap; }
      #b-title span { display: inline-block; opacity: 0; }
      #b-title .a { color: var(--amber); }
      #b-sub { position: absolute; top: 470px; left: 0; right: 0; text-align: center; font-size: 40px; font-weight: 800; color: var(--muted); opacity: 0; }
      #coins { position: absolute; left: 113px; top: 560px; width: 854px; height: 330px; }
      .coin { position: absolute; width: 150px; height: 150px; border-radius: 50%; opacity: 0;
        background: radial-gradient(circle at 40% 35%, #ffe08a 0%, #e3a920 55%, #9c6a06 100%); box-shadow: 0 12px 30px rgba(0,0,0,.45); }
      .coin::before { content: ""; position: absolute; left: 26px; top: 26px; width: 98px; height: 98px; border-radius: 50%;
        background: radial-gradient(circle at 40% 35%, #ffffff 0%, #c9cad1 60%, #8a8c94 100%); }
      .coin b { position: absolute; left: 0; right: 0; top: 42px; text-align: center; font-size: 56px; font-weight: 900; color: #3c3d44; letter-spacing: -.04em; }
      .coin .rd { position: absolute; inset: 0; border-radius: 50%; background: #ff4a2c; mix-blend-mode: multiply; opacity: 0; }
      .coin .rd.q { background: conic-gradient(#ff4a2c 0 25%, rgba(0,0,0,0) 25% 100%); }
      .blab { position: absolute; top: 940px; width: 400px; text-align: center; opacity: 0; }
      .blab .k { font-size: 32px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); }
      .blab .v { font-size: 80px; font-weight: 900; letter-spacing: -.04em; line-height: 1.05; }
      #bl-l { left: 120px; }  #bl-l .v { color: var(--red); }
      #bl-r { left: 560px; }  #bl-r .v { color: var(--cream); }
      #bl-l .k b { color: var(--amber); font-weight: 900; }
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
          <div id="h-t1" class="hl">Ton paquet de<br />cigarettes&nbsp;?</div>
          <div id="h-price"><span id="h-num">13,50</span>&nbsp;€</div>
          <div id="h-kick">Et pour le fabricant&nbsp;?</div>
          <div id="h-stamp" class="stamp"><span>Même pas 1&nbsp;€&nbsp;!</span></div>
        </div>

        <!-- 2. Le paquet découpé -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="ptag">13,50&nbsp;€</div>
          <svg id="tips" width="286" height="40" viewBox="0 0 286 40" aria-hidden="true">
            <rect x="4" y="6" width="50" height="40" rx="10" fill="#e3a14a" /><rect x="62" y="0" width="50" height="46" rx="10" fill="#ece6d6" />
            <rect x="120" y="4" width="50" height="42" rx="10" fill="#e3a14a" /><rect x="178" y="0" width="50" height="46" rx="10" fill="#ece6d6" />
            <rect x="236" y="6" width="46" height="40" rx="10" fill="#e3a14a" />
          </svg>
          <div id="pack">
            <div id="lid"></div>
            <div id="ly-acc" class="layer"><div id="pc-acc" class="pct">66&nbsp;%</div></div>
            <div id="ly-tva" class="layer"><div id="pc-tva" class="pct">17&nbsp;%</div></div>
            <div id="ly-bur" class="layer"></div>
            <div id="ly-fab" class="layer"></div>
          </div>

          <div id="l-fab" class="label"><div class="name"><i style="background:var(--cold)"></i>Le fabricant</div><div class="val"><span id="v-fab">0,00</span>&nbsp;€</div></div>
          <div id="l-bur" class="label"><div class="name"><i style="background:var(--cream)"></i>Le buraliste</div><div class="val"><span id="v-bur">0,00</span>&nbsp;€</div></div>
          <div id="l-tva" class="label"><div class="name"><i style="background:var(--amber)"></i>TVA 20&nbsp;%</div><div class="val"><span id="v-tva">0,00</span>&nbsp;€</div></div>
          <div id="l-acc" class="label"><div class="name"><i style="background:var(--red)"></i>L'accise</div><div class="sub">la taxe sur le tabac</div><div class="val"><span id="v-acc">0,00</span>&nbsp;€</div></div>
          <div id="ch-acc" class="chips"><span id="ca1" class="chip">55&nbsp;% du prix</span><span id="ca2" class="chip">+ 1,47&nbsp;€ fixes</span></div>
          <div id="ch-fab" class="chips"><span id="cf1" class="chip">fabriquer</span><span id="cf2" class="chip">emballer</span><span id="cf3" class="chip">livrer</span></div>
        </div>

        <!-- 3. Bilan -->
        <div id="s-bilan" class="clip" data-start="%%BIL_S%%" data-duration="%%BIL_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="b-title"><span class="a">8&nbsp;€</span> <span>sur</span> <span>10</span></div>
          <div id="b-sub">… et même un peu plus</div>
          <div id="coins"></div>
          <div id="bl-l" class="blab"><div class="k">Taxes <b>→ l'État</b></div><div class="v">11,14&nbsp;€</div></div>
          <div id="bl-r" class="blab"><div class="k">Tout le reste</div><div class="v">2,36&nbsp;€</div></div>
        </div>

        <!-- 4. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="4" data-track-kind="graphics">
          <div id="c-title"><div>Combien ça</div><div>coûte</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 2 · Le paquet de cigarettes</div>
          <div id="c-src">Sources : Douane française, fiscalité des tabacs au 1er janvier 2026 et circulaire du 30/07/2026 · paquet de 20 à 13,50&nbsp;€, France métropolitaine</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMBIEN ÇA COÛTE VRAIMENT&nbsp;?</span><span class="pill num">#2</span>
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

      // ================= 1. ACCROCHE =================
      D.glow("amber", 0, 0.6, 0.01);
      tl.fromTo("#h-price", { scale: 1 }, { keyframes: [{ scale: 1.14, duration: 0.09, ease: "power2.out" }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.p1350 - 0.05);
      D.shake(C.p1350 - 0.02, 8);
      tl.to("#h-price", { opacity: 0.35, scale: 0.92, duration: 0.3 }, C.fabricant - 0.1);
      D.blurIn("#h-kick", C.fabricant - 0.1);
      D.stamp("#h-stamp span", C.pas, -5);
      D.shake(C.pas + 0.02, 14);
      D.flash(C.pas + 0.02, 0.22);
      D.glow("amber", C.euro, 0, 0.4); D.glow("red", C.euro, 0.6, 0.3);
      D.blurOut(["#h-t1", "#h-kick"], C.regarde - 0.42, 0.14);
      D.blurOut("#h-stamp span", C.regarde - 0.2, 0.16);
      // le prix devient l'étiquette du paquet
      tl.to("#h-price", { opacity: 1, scale: 0.29, x: -285, y: -351, duration: 0.3, ease: "power3.inOut" }, C.regarde - 0.3);
      D.glow("red", C.regarde - 0.2, 0, 0.4); D.glow("cream", C.regarde - 0.2, 0.5, 0.4);

      // ================= 2. LE PAQUET =================
      tl.set("#ptag", { opacity: 1 }, C.regarde - 0.02);
      tl.fromTo("#pack", { opacity: 0, y: 120, filter: "blur(10px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, C.regarde - 0.05);
      tl.fromTo("#tips", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.4, ease: "back.out(2)" }, C.regarde + 0.2);

      // l'accise
      D.glow("cream", C.accise - 0.2, 0, 0.4); D.glow("red", C.accise - 0.2, 0.7, 0.4);
      tl.fromTo("#ly-acc", { y: 430 }, { y: 0, duration: 1.3, ease: "power2.out" }, C.accise);
      D.blurIn("#l-acc", C.accise);
      D.popIn("#ca1", C.p55 - 0.05, 0.5);
      D.popIn("#ca2", C.montant - 0.05, 0.5);
      D.blurIn("#l-acc .val", C.total - 0.1, 0.16);
      D.count("v-acc", 0, 8.89, C.total - 0.05, 1.0);
      tl.to("#pc-acc", { opacity: 1, duration: 0.25 }, C.v889 + 0.2);

      // la TVA
      tl.to(["#l-acc", "#ch-acc"], { opacity: 0.32, duration: 0.3 }, C.tva - 0.3);
      D.glow("red", C.tva - 0.2, 0.2, 0.4); D.glow("amber", C.tva - 0.2, 0.7, 0.4);
      tl.fromTo("#ly-tva", { y: 540 }, { y: 0, duration: 0.9, ease: "power2.out" }, C.tva - 0.1);
      D.blurIn("#l-tva", C.tva - 0.1);
      D.blurIn("#l-tva .val", C.v225 - 0.12, 0.16);
      D.count("v-tva", 0, 2.25, C.v225 - 0.1, 0.8);
      tl.to("#pc-tva", { opacity: 1, duration: 0.25 }, C.v225 + 0.3);

      // le buraliste
      tl.to("#l-tva", { opacity: 0.32, duration: 0.3 }, C.buraliste - 0.3);
      D.glow("amber", C.buraliste - 0.2, 0, 0.4); D.glow("cream", C.buraliste - 0.2, 0.5, 0.4);
      tl.fromTo("#ly-bur", { y: 600 }, { y: 0, duration: 0.8, ease: "power2.out" }, C.buraliste - 0.1);
      D.blurIn("#l-bur", C.buraliste - 0.1);
      D.blurIn("#l-bur .val", C.v139 - 0.12, 0.16);
      D.count("v-bur", 0, 1.39, C.v139 - 0.1, 0.8);

      // le fabricant : la miette
      tl.to("#l-bur", { opacity: 0.32, duration: 0.3 }, C.fab2 - 0.3);
      tl.to("#ch-acc", { opacity: 0, duration: 0.3 }, C.fab2 - 0.3);
      D.glow("cream", C.fab2 - 0.2, 0, 0.4); D.glow("cold", C.fab2 - 0.2, 0.6, 0.4);
      tl.fromTo("#ly-fab", { y: 660 }, { y: 0, duration: 0.7, ease: "power2.out" }, C.fab2 - 0.1);
      D.blurIn("#l-fab", C.fab2 - 0.1);
      D.blurIn("#l-fab .val", C.v97 - 0.12, 0.16);
      D.count("v-fab", 0, 0.97, C.v97 - 0.1, 0.7);
      tl.fromTo("#l-fab .val", { scale: 1, transformOrigin: "0% 50%" }, { keyframes: [{ scale: 1.14, duration: 0.09 }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.centimes);
      tl.fromTo("#ly-fab", { filter: "brightness(1)" }, { keyframes: [{ filter: "brightness(1.6)", duration: 0.15 }, { filter: "brightness(1)", duration: 0.4 }], repeat: 1 }, C.centimes);
      D.shake(C.centimes + 0.02, 8);
      D.popIn("#cf1", C.fabriquer - 0.05, 0.5);
      D.popIn("#cf2", C.emballer - 0.05, 0.5);
      D.popIn("#cf3", C.livrer - 0.05, 0.5);
      // tout se rallume
      tl.to(["#l-acc", "#l-tva", "#l-bur"], { opacity: 1, duration: 0.3 }, C.livrer + 0.1);
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.32, ease: "power3.in" }, C.resultat - 0.3);

      // ================= 3. BILAN : 8 € SUR 10 =================
      D.glow("cold", C.resultat - 0.2, 0, 0.4); D.glow("amber", C.resultat - 0.1, 0.6, 0.4);
      tl.fromTo("#b-title span", { opacity: 0, filter: "blur(10px)", y: 30 }, { opacity: 1, filter: "blur(0px)", y: 0, duration: 0.16, stagger: 0.09, ease: "power3.out" }, C.huit - 0.1);
      D.flash(C.huit, 0.14, "#ffb21f");
      { const box = document.getElementById("coins"), coins = [];
        for (let j = 0; j < 10; j++) { const c = document.createElement("div"); c.className = "coin";
          c.style.left = (j % 5) * 176 + "px"; c.style.top = Math.floor(j / 5) * 176 + "px";
          c.innerHTML = `<b>1€</b><div class="rd${j === 8 ? " q" : ""}"></div>`; box.appendChild(c); coins.push(c); }
        coins.forEach((c, j) => tl.fromTo(c, { opacity: 0, scale: 0.3, rotation: -40 }, { opacity: 1, scale: 1, rotation: 0, duration: 0.35, ease: "back.out(2)" }, C.resultat + 0.05 + j * 0.05));
        coins.slice(0, 9).forEach((c, j) => tl.to(c.querySelector(".rd"), { opacity: 0.8, duration: 0.12 }, C.huit + 0.15 + j * 0.07));
        tl.to(coins.slice(0, 9), { y: -14, duration: 0.18, yoyo: true, repeat: 1, stagger: 0.04, ease: "power2.out" }, C.etat - 0.05); }
      tl.to("#b-sub", { opacity: 1, duration: 0.3 }, C.partent - 0.1);
      tl.fromTo("#bl-l", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.partent);
      tl.fromTo("#bl-r", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.partent + 0.08);
      tl.fromTo("#bl-l .v", { scale: 1 }, { keyframes: [{ scale: 1.15, duration: 0.08 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, C.etat);
      D.shake(C.etat + 0.02, 12);
      D.glow("red", C.etat - 0.1, 0.7, 0.35);
      tl.to("#s-bilan", { x: -460, opacity: 0, filter: "blur(14px)", duration: 0.26, ease: "power3.in" }, C.abonne - 0.25);

      // ================= 4. CARTE DE FIN =================
      D.glow("red", C.abonne - 0.2, 0, 0.4); D.glow("amber", C.abonne - 0.2, 0.6, 0.4);
      D.endCard(C.abonne - 0.05, C.vraiment);

      D.captions(CAP);
      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
