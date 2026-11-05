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
      #h-t1 { top: 320px; font-size: 100px; }
      #h-pass { position: absolute; left: 290px; top: 540px; width: 500px; height: 316px; border-radius: 34px;
        background: linear-gradient(135deg, #2b2f3a 0%, #15161c 100%); border: 4px solid var(--cream); box-shadow: 0 30px 90px rgba(0,0,0,.5); }
      #h-pass .chipc { position: absolute; left: 44px; top: 106px; width: 84px; height: 64px; border-radius: 14px;
        background: linear-gradient(135deg, #ffe08a, #c98d12); }
      #h-pass .nm { position: absolute; left: 44px; top: 36px; font-size: 40px; font-weight: 900; letter-spacing: .02em; color: var(--cream); }
      #h-pass .ln { position: absolute; left: 44px; height: 16px; border-radius: 8px; background: rgba(236,230,214,.22); }
      #h-pass .pz { position: absolute; right: 40px; bottom: 30px; font-size: 92px; font-weight: 900; letter-spacing: -.045em; color: var(--amber); white-space: nowrap; }
      #h-kick { position: absolute; left: 0; right: 0; top: 900px; text-align: center; font-size: 50px; font-weight: 800; color: var(--cream); }
      #h-real { position: absolute; left: 0; right: 0; top: 860px; text-align: center; font-size: 230px; font-weight: 900;
        letter-spacing: -.05em; line-height: 1; color: var(--red); white-space: nowrap; opacity: 0; }
      #h-stamp { top: 1100px; }
      #h-costs { position: absolute; left: 60px; right: 60px; top: 1080px; display: flex; flex-wrap: wrap; justify-content: center; gap: 14px; }
      #h-costs .chip { position: relative; }
      .chip i { display: block; width: 22px; height: 22px; border-radius: 50%; }

      /* ---------- la barre « vrai prix » ---------- */
      #ptag { position: absolute; left: 90px; top: 318px; width: 330px; height: 112px; border-radius: 28px; background: var(--panel);
        border: 3px solid var(--line); display: flex; align-items: center; justify-content: center; opacity: 0;
        font-size: 72px; font-weight: 900; letter-spacing: -.04em; color: var(--red); white-space: nowrap; }
      #pack { position: absolute; left: 90px; top: 456px; width: 330px; height: 670px; border-radius: 36px;
        border: 5px solid var(--cream); background: #111115; overflow: hidden; opacity: 0; }
      .layer { position: absolute; left: 0; width: 320px; overflow: hidden; }
      #ly-toi { bottom: 0; height: 214px; z-index: 4; background: linear-gradient(180deg, #7fd6ff, #2ea9e8); }
      #ly-col { bottom: 214px; height: 79px; z-index: 3; background: linear-gradient(180deg, #f4efe2, #d8d0bb); }
      #ly-aut { bottom: 293px; height: 47px; z-index: 2; background: linear-gradient(180deg, #ffc451, #f39a00); }
      #ly-ent { bottom: 340px; height: 320px; z-index: 1; background: linear-gradient(180deg, #ff6c4e, #e43a1f); }
      #half { position: absolute; left: 0; right: 0; top: 0; height: 107px; opacity: 0;
        background: repeating-linear-gradient(-45deg, rgba(11,11,14,.55) 0 14px, rgba(11,11,14,0) 14px 28px); border-bottom: 4px dashed rgba(11,11,14,.7); }
      .pct { position: absolute; left: 0; right: 0; top: 50%; margin-top: -32px; text-align: center; font-size: 58px; font-weight: 900;
        letter-spacing: -.03em; color: rgba(11,11,14,.85); opacity: 0; }

      .label { position: absolute; left: 470px; width: 560px; opacity: 0; }
      .label .name { display: flex; align-items: center; gap: 14px; font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; white-space: nowrap; }
      .label .name i { display: block; width: 22px; height: 22px; border-radius: 6px; }
      .label .sub { font-size: 30px; font-weight: 600; color: var(--muted); margin-top: 4px; white-space: nowrap; }
      .label .val { font-size: 84px; font-weight: 900; letter-spacing: -.045em; line-height: 1.04; margin-top: 2px; white-space: nowrap; opacity: 0; }
      #l-ent { top: 300px; }  #l-ent .val { color: var(--red); font-size: 100px; }
      #l-aut { top: 620px; }  #l-aut .val { color: var(--amber); }
      #l-col { top: 750px; }  #l-col .val { color: var(--cream); }
      #l-toi { top: 930px; }  #l-toi .val { color: var(--cold); }
      .chips { position: absolute; left: 470px; width: 580px; display: flex; flex-wrap: wrap; gap: 12px; }
      .chips .chip { position: relative; font-size: 30px; padding: 10px 20px; }
      #ch-ent { top: 470px; }
      #ch-toi { top: 1070px; }

      /* ---------- bilan ---------- */
      #b-title { position: absolute; top: 300px; left: 0; right: 0; text-align: center; font-size: 130px; font-weight: 900;
        letter-spacing: -.05em; line-height: 1; text-transform: uppercase; white-space: nowrap; }
      #b-title span { display: inline-block; opacity: 0; }
      #b-title .a { color: var(--amber); }
      #b-sub { position: absolute; top: 470px; left: 0; right: 0; text-align: center; font-size: 40px; font-weight: 800; color: var(--muted); opacity: 0; }
      #coins { position: absolute; left: 115px; top: 590px; width: 850px; height: 380px; }
      .coin { position: absolute; width: 180px; height: 180px; border-radius: 50%; opacity: 0;
        background: radial-gradient(circle at 40% 35%, #ffe08a 0%, #e3a920 55%, #9c6a06 100%); box-shadow: 0 12px 30px rgba(0,0,0,.45); }
      .coin::before { content: ""; position: absolute; left: 30px; top: 30px; width: 120px; height: 120px; border-radius: 50%;
        background: radial-gradient(circle at 40% 35%, #ffffff 0%, #c9cad1 60%, #8a8c94 100%); }
      .coin b { position: absolute; left: 0; right: 0; top: 54px; text-align: center; font-size: 60px; font-weight: 900; color: #3c3d44; letter-spacing: -.04em; }
      .coin .rd { position: absolute; inset: 0; border-radius: 50%; mix-blend-mode: multiply; opacity: 0; background: #ff4a2c; }
      .coin.me .rd { background: #4cc4ff; mix-blend-mode: normal; }
      .blab { position: absolute; top: 990px; width: 420px; text-align: center; opacity: 0; }
      .blab .k { font-size: 32px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; color: var(--muted); }
      .blab .v { font-size: 80px; font-weight: 900; letter-spacing: -.04em; line-height: 1.05; white-space: nowrap; }
      #bl-l { left: 100px; }  #bl-l .v { color: var(--cold); }
      #bl-r { left: 560px; }  #bl-r .v { color: var(--red); }
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
          <div id="h-t1" class="hl">Ton passe<br />Navigo&nbsp;?</div>
          <div id="h-pass">
            <div class="nm">PASSE MENSUEL</div>
            <div class="chipc"></div>
            <div class="ln" style="top:206px;width:200px"></div>
            <div class="ln" style="top:236px;width:130px"></div>
            <div class="pz"><span id="h-num">90,80</span>&nbsp;€</div>
          </div>
          <div id="h-kick">Et son <span style="color:var(--red)">vrai</span> prix&nbsp;?</div>
          <div id="h-real"><span id="h-rnum">90</span>&nbsp;€</div>
          <div id="h-stamp" class="stamp"><span>Chaque mois&nbsp;!</span></div>
          <div id="h-costs">
            <span id="hc1" class="chip"><i style="background:var(--cream)"></i>Trains</span>
            <span id="hc2" class="chip"><i style="background:var(--cream)"></i>Bus</span>
            <span id="hc3" class="chip"><i style="background:var(--cream)"></i>Conducteurs</span>
            <span id="hc4" class="chip"><i style="background:var(--amber)"></i>Électricité</span>
          </div>
        </div>

        <!-- 2. Le vrai prix découpé -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="ptag">280&nbsp;€</div>
          <div id="pack" data-layout-allow-overflow>
            <div id="ly-ent" class="layer"><div id="pc-ent" class="pct">49&nbsp;%</div></div>
            <div id="ly-aut" class="layer"></div>
            <div id="ly-col" class="layer"></div>
            <div id="ly-toi" class="layer"><div id="half"></div><div id="pc-toi" class="pct" style="margin-top:6px">32&nbsp;%</div></div>
          </div>

          <div id="l-ent" class="label"><div class="name"><i style="background:var(--red)"></i>Les entreprises</div><div class="val"><span id="v-ent">0,00</span>&nbsp;€</div></div>
          <div id="ch-ent" class="chips"><span id="ce1" class="chip">Versement mobilité</span><span id="ce2" class="chip">même sans métro</span></div>
          <div id="l-aut" class="label"><div class="name"><i style="background:var(--amber)"></i>Pub, amendes, taxes</div><div class="val"><span id="v-aut">0,00</span>&nbsp;€</div></div>
          <div id="l-col" class="label"><div class="name"><i style="background:var(--cream)"></i>Les collectivités</div><div class="sub">Région, Paris, départements</div><div class="val"><span id="v-col">0,00</span>&nbsp;€</div></div>
          <div id="l-toi" class="label"><div class="name"><i style="background:var(--cold)"></i>Toi</div><div class="val"><span id="v-toi">0,00</span>&nbsp;€</div></div>
          <div id="ch-toi" class="chips"><span id="ct1" class="chip">Employeur&nbsp;: −50&nbsp;%</span></div>
        </div>

        <!-- 3. Bilan -->
        <div id="s-bilan" class="clip" data-start="%%BIL_S%%" data-duration="%%BIL_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="b-title"><span>Moins</span> <span>de</span> <span class="a">1&nbsp;€</span><br /><span>sur</span> <span class="a">6</span></div>
          <div id="coins"></div>
          <div id="bl-l" class="blab"><div class="k">Toi, remboursé</div><div class="v">45,40&nbsp;€</div></div>
          <div id="bl-r" class="blab"><div class="k">Payé par les autres</div><div class="v">234,67&nbsp;€</div></div>
        </div>

        <!-- 4. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="4" data-track-kind="graphics">
          <div id="c-title"><div>Combien ça</div><div>coûte</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 3 · Le passe Navigo</div>
          <div id="c-src">Sources : Île-de-France Mobilités (tarifs 2026, compte administratif 2025) · passe mensuel toutes zones</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMBIEN ÇA COÛTE VRAIMENT&nbsp;?</span><span class="pill num">#3</span>
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
      D.glow("amber", 0, 0.55, 0.01);
      tl.fromTo("#h-pass", { rotation: -4, y: 0 }, { rotation: 2, y: -10, duration: C.vrai, ease: "sine.inOut" }, 0);
      tl.fromTo("#h-pass .pz", { scale: 1 }, { keyframes: [{ scale: 1.14, duration: 0.09, ease: "power2.out" }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.p9080 - 0.05);
      // le vrai prix monte
      D.blurOut("#h-kick", C.p280 - 0.5, 0.14);
      tl.to("#h-pass", { opacity: 0.4, scale: 0.86, duration: 0.3 }, C.p280 - 0.5);
      tl.fromTo("#h-real", { opacity: 0, scale: 0.7, y: 0 }, { opacity: 1, scale: 1, duration: 0.25, ease: "expo.out" }, C.p280 - 0.5);
      D.count("h-rnum", 90.8, 280, C.p280 - 0.45, 1.1, 0);
      D.glow("amber", C.p280, 0, 0.4); D.glow("red", C.p280, 0.65, 0.3);
      tl.fromTo("#h-real", { scale: 1 }, { keyframes: [{ scale: 1.12, duration: 0.08 }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.p280 + 0.65);
      D.shake(C.p280 + 0.67, 10);
      D.stamp("#h-stamp span", C.chaque, -5);
      D.flash(C.chaque + 0.02, 0.18);
      // ce que ça paie
      D.blurOut("#h-stamp span", C.trains - 0.25, 0.14);
      D.popIn("#hc1", C.trains - 0.05, 0.5);
      D.popIn("#hc2", C.bus - 0.05, 0.5);
      D.popIn("#hc3", C.conducteurs - 0.05, 0.5);
      D.popIn("#hc4", C.elec - 0.05, 0.5);
      tl.to("#h-costs .chip", { y: -10, duration: 0.15, yoyo: true, repeat: 1, stagger: 0.05 }, C.cher - 0.05);
      D.blurOut(["#h-t1", "#h-pass", "#h-costs"], C.regarde - 0.4, 0.15);
      // le vrai prix devient l'étiquette de la barre
      tl.to("#h-real", { scale: 0.32, x: -285, y: -601, duration: 0.32, ease: "power3.inOut" }, C.regarde - 0.3);
      D.glow("red", C.regarde - 0.2, 0, 0.4); D.glow("cream", C.regarde - 0.2, 0.5, 0.4);

      // ================= 2. QUI PAIE ? =================
      tl.set("#ptag", { opacity: 1 }, C.regarde + 0.0);
      tl.fromTo("#pack", { opacity: 0, y: 120, filter: "blur(10px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, C.regarde - 0.05);

      // toi
      D.glow("cream", C.toi - 0.3, 0, 0.4); D.glow("cold", C.toi - 0.3, 0.6, 0.4);
      tl.fromTo("#ly-toi", { y: 220 }, { y: 0, duration: 1.0, ease: "power2.out" }, C.toi - 0.1);
      D.blurIn("#l-toi", C.toi - 0.1);
      D.blurIn("#l-toi .val", C.toi9080 - 0.12, 0.16);
      D.count("v-toi", 0, 90.8, C.toi9080 - 0.1, 0.8);
      tl.to("#pc-toi", { opacity: 1, duration: 0.25 }, C.toi9080 + 0.3);
      D.popIn("#ct1", C.employeur - 0.05, 0.5);
      tl.to("#half", { opacity: 1, duration: 0.35 }, C.moitie - 0.05);
      tl.to("#pc-toi", { opacity: 0, duration: 0.2 }, C.moitie - 0.05);
      D.count("v-toi", 90.8, 45.4, C.v4540 - 0.2, 1.0);
      tl.fromTo("#l-toi .val", { scale: 1, transformOrigin: "0% 50%" }, { keyframes: [{ scale: 1.12, duration: 0.09 }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.v4540 + 0.8);

      // les collectivités
      tl.to(["#l-toi", "#ch-toi"], { opacity: 0.32, duration: 0.3 }, C.collectivites - 0.3);
      D.glow("cold", C.collectivites - 0.2, 0.15, 0.4); D.glow("cream", C.collectivites - 0.2, 0.55, 0.4);
      tl.fromTo("#ly-col", { y: 320 }, { y: 0, duration: 0.8, ease: "power2.out" }, C.collectivites - 0.1);
      D.blurIn("#l-col", C.collectivites - 0.1);
      D.blurIn("#l-col .val", C.v3310 - 0.12, 0.16);
      D.count("v-col", 0, 33.1, C.v3310 - 0.1, 0.8);

      // pub, amendes, taxes
      tl.to("#l-col", { opacity: 0.32, duration: 0.3 }, C.pub - 0.3);
      D.glow("cream", C.pub - 0.2, 0.1, 0.4); D.glow("amber", C.pub - 0.2, 0.55, 0.4);
      tl.fromTo("#ly-aut", { y: 360 }, { y: 0, duration: 0.7, ease: "power2.out" }, C.pub - 0.1);
      D.blurIn("#l-aut", C.pub - 0.1);
      D.blurIn("#l-aut .val", C.v1947 - 0.12, 0.16);
      D.count("v-aut", 0, 19.47, C.v1947 - 0.1, 0.8);

      // les entreprises : le gros morceau
      tl.to("#l-aut", { opacity: 0.32, duration: 0.3 }, C.gros - 0.3);
      D.glow("amber", C.gros - 0.2, 0, 0.4); D.glow("red", C.gros - 0.2, 0.7, 0.4);
      tl.fromTo("#ly-ent", { y: 680 }, { y: 0, duration: 1.2, ease: "power2.out" }, C.entreprises - 0.15);
      D.blurIn("#l-ent", C.entreprises - 0.1);
      D.blurIn("#l-ent .val", C.v13669 - 0.12, 0.16);
      D.count("v-ent", 0, 136.69, C.v13669 - 0.1, 1.2);
      tl.to("#pc-ent", { opacity: 1, duration: 0.25 }, C.presque - 0.1);
      tl.fromTo("#ly-ent", { filter: "brightness(1)" }, { keyframes: [{ filter: "brightness(1.5)", duration: 0.15 }, { filter: "brightness(1)", duration: 0.4 }], repeat: 1 }, C.presque);
      D.shake(C.presque + 0.02, 8);
      D.popIn("#ce1", C.versement - 0.05, 0.5);
      D.popIn("#ce2", C.metro - 0.3, 0.5);
      // tout se rallume
      tl.to(["#l-toi", "#ch-toi", "#l-col", "#l-aut"], { opacity: 1, duration: 0.3 }, C.metro - 0.2);
      tl.to("#s-main", { scale: 1.3, opacity: 0, filter: "blur(16px)", duration: 0.32, ease: "power3.in" }, C.resultat - 0.3);

      // ================= 3. BILAN : MOINS D'1 € SUR 6 =================
      D.glow("red", C.resultat - 0.2, 0, 0.4); D.glow("cold", C.resultat - 0.1, 0.5, 0.4);
      { const box = document.getElementById("coins"), coins = [];
        for (let j = 0; j < 6; j++) { const c = document.createElement("div"); c.className = "coin" + (j === 0 ? " me" : "");
          c.style.left = (j % 3) * 335 + "px"; c.style.top = Math.floor(j / 3) * 200 + "px";
          c.innerHTML = `<b>1€</b><div class="rd"></div>`; box.appendChild(c); coins.push(c); }
        coins.forEach((c, j) => tl.fromTo(c, { opacity: 0, scale: 0.3, rotation: -40 }, { opacity: 1, scale: 1, rotation: 0, duration: 0.35, ease: "back.out(2)" }, C.resultat + 0.1 + j * 0.07));
        tl.to(coins[0].querySelector(".rd"), { opacity: 0.75, duration: 0.15 }, C.moins);
        coins.slice(1).forEach((c, j) => tl.to(c.querySelector(".rd"), { opacity: 0.7, duration: 0.12 }, C.six + 0.05 + j * 0.06));
        tl.fromTo(coins[0], { scale: 1 }, { keyframes: [{ scale: 1.15, duration: 0.1 }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, C.moins); }
      tl.fromTo("#b-title span", { opacity: 0, filter: "blur(10px)", y: 30 }, { opacity: 1, filter: "blur(0px)", y: 0, duration: 0.16, stagger: 0.1, ease: "power3.out" }, C.moins - 0.15);
      D.flash(C.six, 0.14, "#ffb21f");
      D.shake(C.six + 0.02, 12);
      tl.fromTo("#bl-l", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.resultat + 0.6);
      tl.fromTo("#bl-r", { opacity: 0, y: 30 }, { opacity: 1, y: 0, duration: 0.3, ease: "power3.out" }, C.resultat + 0.75);
      tl.to("#s-bilan", { x: -460, opacity: 0, filter: "blur(14px)", duration: 0.26, ease: "power3.in" }, C.abonne - 0.25);

      // ================= 4. CARTE DE FIN =================
      D.glow("cold", C.abonne - 0.2, 0, 0.4); D.glow("amber", C.abonne - 0.2, 0.6, 0.4);
      D.endCard(C.abonne - 0.05, C.vraiment);

      D.captions(CAP);
      window.__timelines = window.__timelines || {};
      window.__timelines["main"] = tl;
      tl.seek(0);
    </script>
  </body>
</html>
