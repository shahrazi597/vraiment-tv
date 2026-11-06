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
      #h-t1 { top: 310px; font-size: 100px; }
      #hk { position: absolute; left: 0; top: 0; }
      #h-kick { position: absolute; left: 0; right: 0; top: 960px; text-align: center; font-size: 54px; font-weight: 800; color: var(--cream); opacity: 0; }
      #h-stamp { top: 1070px; }

      /* ---------- la barre ---------- */
      #ptag { position: absolute; left: 90px; top: 300px; width: 330px; height: 104px; border-radius: 28px; background: var(--panel);
        border: 3px solid var(--line); display: flex; align-items: center; justify-content: center; opacity: 0;
        font-size: 68px; font-weight: 900; letter-spacing: -.04em; color: var(--amber); white-space: nowrap; }
      #bar { position: absolute; left: 90px; top: 420px; width: 330px; height: 710px; border-radius: 34px; border: 5px solid var(--cream);
        background: #111115; overflow: hidden; opacity: 0; }
      .sl { position: absolute; left: 0; right: 0; background: #2a2a32; border-bottom: 2px solid #0b0b0e; }
      #sl-tva { top: 0; height: 37px; }
      #sl-cnc { top: 37px; height: 72px; }
      #sl-sac { top: 109px; height: 10px; }
      #sl-dis { top: 119px; height: 283px; }
      #sl-sal { top: 402px; height: 308px; border-bottom: 0; }
      .sl .pct { position: absolute; left: 0; right: 0; top: 50%; margin-top: -34px; text-align: center; font-size: 60px; font-weight: 900;
        letter-spacing: -.03em; color: rgba(11,11,14,.85); opacity: 0; }

      .label { position: absolute; left: 470px; width: 580px; opacity: 0; }
      .label .name { display: flex; align-items: center; gap: 14px; font-size: 34px; font-weight: 800; letter-spacing: .05em; text-transform: uppercase; white-space: nowrap; }
      .label .name i { display: block; width: 22px; height: 22px; border-radius: 6px; }
      .label .sub { font-size: 30px; font-weight: 600; color: var(--muted); margin-top: 4px; white-space: nowrap; }
      .label .val { font-size: 84px; font-weight: 900; letter-spacing: -.045em; line-height: 1.04; margin-top: 2px; white-space: nowrap; opacity: 0; }
      #l-tva { top: 410px; } #l-tva .val { color: var(--cream); }
      #l-cnc { top: 600px; } #l-cnc .val { color: var(--cold); }
      #l-sac { top: 520px; } #l-sac .val { color: var(--cream); }
      #l-dis { top: 470px; } #l-dis .val { color: var(--amber); }
      #l-sal { top: 860px; } #l-sal .val { color: var(--red); }
      .chips { position: absolute; left: 470px; width: 580px; display: flex; flex-wrap: wrap; gap: 12px; }
      .chips .chip { position: relative; font-size: 30px; padding: 10px 20px; }
      .chip i { display: block; width: 20px; height: 20px; border-radius: 50%; }
      #ch-dis { top: 680px; }

      /* ---------- bonus ---------- */
      #b-num { position: absolute; left: 0; right: 0; top: 330px; text-align: center; font-size: 200px; font-weight: 900; letter-spacing: -.05em;
        color: var(--cold); line-height: 1; opacity: 0; white-space: nowrap; }
      #b-sub { position: absolute; left: 0; right: 0; top: 545px; text-align: center; font-size: 40px; font-weight: 800; color: var(--muted); opacity: 0; }
      #b-arrow { position: absolute; left: 0; top: 0; }
      #b-card { position: absolute; left: 190px; top: 760px; width: 700px; height: 190px; border-radius: 30px; background: var(--panel);
        border: 4px solid var(--cold); opacity: 0; display: flex; align-items: center; gap: 30px; padding: 0 40px; }
      #b-card .flag { display: flex; width: 120px; height: 84px; border-radius: 10px; overflow: hidden; flex: none; }
      #b-card .flag i { flex: 1; }
      #b-card .t { font-size: 58px; font-weight: 900; letter-spacing: -.03em; text-transform: uppercase; line-height: 1; white-space: nowrap; }
      #b-chip { position: absolute; left: 0; right: 0; top: 1000px; display: flex; justify-content: center; }
      #b-chip .chip { position: relative; }

      /* ---------- chute : le pop-corn ---------- */
      #tw-title { top: 300px; font-size: 100px; }
      #tw-title .wsp { opacity: 0; }
      #pop { position: absolute; left: 0; top: 0; opacity: 0; }
      #tw-stamp { top: 1000px; }
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
          <div id="h-t1" class="hl">Ta place<br />de <span class="a">ciné&nbsp;?</span></div>
          <svg id="hk" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <g id="ticket">
              <path d="M210 590 H870 a0 0 0 0 1 0 0 V665 a36 36 0 0 0 0 72 V810 H210 V737 a36 36 0 0 0 0 -72 Z" fill="#16161b" stroke="#ece6d6" stroke-width="6" stroke-linejoin="round" />
              <line x1="690" y1="604" x2="690" y2="796" stroke="#ece6d6" stroke-width="5" stroke-dasharray="12 12" opacity=".6" />
              <text x="270" y="660" font-family="Inter Display" font-weight="800" font-size="34" letter-spacing="4" fill="#8e8c95">CINÉMA · ENTRÉE</text>
              <text x="266" y="770" font-family="Inter Display" font-weight="900" font-size="112" letter-spacing="-4" fill="#ffb21f"><tspan id="h-num">7,42</tspan> €</text>
              <g fill="#ece6d6" opacity=".85"><rect x="738" y="640" width="104" height="26" rx="6" /><rect x="738" y="688" width="104" height="26" rx="6" /><rect x="738" y="736" width="104" height="26" rx="6" /></g>
            </g>
          </svg>
          <div id="h-kick">Et le <span style="color:var(--red)">film</span>, lui&nbsp;?</div>
          <div id="h-stamp" class="stamp"><span>Pas la moitié&nbsp;!</span></div>
        </div>

        <!-- 2. Qui prend quoi -->
        <div id="s-main" class="clip" data-start="%%MAIN_S%%" data-duration="%%MAIN_D%%" data-track-index="2" data-track-kind="graphics">
          <div id="ptag"><span id="p-num">7,42</span>&nbsp;€</div>
          <div id="bar" data-layout-allow-overflow>
            <div id="sl-tva" class="sl"></div>
            <div id="sl-cnc" class="sl"></div>
            <div id="sl-sac" class="sl"></div>
            <div id="sl-dis" class="sl"><div id="pc-dis" class="pct">40&nbsp;%</div></div>
            <div id="sl-sal" class="sl"><div id="pc-sal" class="pct">43&nbsp;%</div></div>
          </div>
          <div id="l-tva" class="label"><div class="name"><i style="background:var(--cream)"></i>L'État · TVA</div><div class="val"><span id="v-tva">0,00</span>&nbsp;€</div></div>
          <div id="l-cnc" class="label"><div class="name"><i style="background:var(--cold)"></i>Taxe CNC</div><div class="sub">Centre national du cinéma</div><div class="val"><span id="v-cnc">0,00</span>&nbsp;€</div></div>
          <div id="l-sac" class="label"><div class="name"><i style="background:var(--cream)"></i>La Sacem</div><div class="sub">La musique du film</div><div class="val"><span id="v-sac">0,00</span>&nbsp;€</div></div>
          <div id="l-dis" class="label"><div class="name"><i style="background:var(--amber)"></i>Le distributeur</div><div class="val"><span id="v-dis">0,00</span>&nbsp;€</div></div>
          <div id="ch-dis" class="chips"><span id="cd1" class="chip"><i style="background:var(--amber)"></i>La pub du film</span><span id="cd2" class="chip"><i style="background:var(--amber)"></i>Le producteur</span></div>
          <div id="l-sal" class="label"><div class="name"><i style="background:var(--red)"></i>La salle</div><div class="val"><span id="v-sal">0,00</span>&nbsp;€</div></div>

          <!-- bonus -->
          <div id="b-num">0,75&nbsp;€</div>
          <div id="b-sub">de taxe sur chaque place</div>
          <svg id="b-arrow" width="1080" height="1920" viewBox="0 0 1080 1920" aria-hidden="true">
            <path id="b-line" d="M540 620 V735" fill="none" stroke="#4cc4ff" stroke-width="8" stroke-linecap="round" />
            <path id="b-head" d="M518 712 L540 738 L562 712" fill="none" stroke="#4cc4ff" stroke-width="8" stroke-linecap="round" stroke-linejoin="round" opacity="0" />
          </svg>
          <div id="b-card"><div class="flag"><i style="background:#2f5bd3"></i><i style="background:#f6f4ee"></i><i style="background:#ff5236"></i></div><div class="t">Les films<br /><span style="color:var(--cold)">français</span></div></div>
          <div id="b-chip"><span id="bc1" class="chip"><i style="background:var(--red)"></i>Même pour un blockbuster américain</span></div>

          <!-- chute -->
          <div id="tw-title" class="hl"><span class="wsp">Et</span> <span class="wsp">le</span><br /><span class="wsp a">pop-corn&nbsp;?</span></div>
          <svg id="pop" width="1080" height="1920" viewBox="0 20 1080 1920" aria-hidden="true">
            <g id="kern" fill="#ece6d6">
              <circle cx="430" cy="640" r="46" /><circle cx="500" cy="608" r="52" /><circle cx="580" cy="612" r="50" /><circle cx="650" cy="645" r="44" />
              <circle cx="465" cy="580" r="40" /><circle cx="545" cy="560" r="46" /><circle cx="620" cy="575" r="40" /><circle cx="540" cy="650" r="44" />
            </g>
            <g fill="#ffb21f" opacity=".55"><circle cx="490" cy="596" r="12" /><circle cx="600" cy="600" r="10" /><circle cx="540" cy="548" r="10" /></g>
            <path d="M390 660 H690 L655 1010 H425 Z" fill="#ece6d6" />
            <path d="M432 660 H478 L486 1010 H452 Z M526 660 H572 L568 1010 H532 Z M620 660 H666 L640 1010 H614 Z" fill="#ff5236" />
            <rect x="380" y="650" width="320" height="26" rx="10" fill="#ff5236" />
          </svg>
          <div id="tw-stamp" class="stamp"><span>100&nbsp;% salle&nbsp;!</span></div>
        </div>

        <!-- 3. Carte de fin -->
        <div id="s-cta" class="clip" data-start="%%CTA_S%%" data-duration="%%CTA_D%%" data-track-index="3" data-track-kind="graphics">
          <div id="c-title"><div>Combien ça</div><div>coûte</div><div class="a">vraiment&nbsp;?</div></div>
          <div id="c-btn"><span>Abonne-toi</span></div>
          <div id="c-ep">Épisode 4 · La place de cinéma</div>
          <div id="c-src">Prix moyen 2025 (7,42&nbsp;€), taux moyen de location de 47,1&nbsp;%. Sources : CNC (bilan 2025, taxe sur les entrées) · Sénat, rapport n° 701 (2023)</div>
        </div>
      </div>

      <div id="caps" class="clip" data-start="%%CAPS_S%%" data-duration="%%CAPS_D%%" data-track-index="5" data-track-kind="captions">
%%CAPTIONS%%
      </div>

      <div id="tag" class="clip" data-start="0" data-duration="%%END%%" data-track-index="6" data-track-kind="graphics">
        <span class="pill">COMBIEN ÇA COÛTE VRAIMENT&nbsp;?</span><span class="pill num">#4</span>
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
      tl.fromTo("#ticket", { rotation: -4, y: 0 }, { rotation: 2, y: -10, svgOrigin: "540 700", duration: C.alors, ease: "sine.inOut" }, 0);
      tl.fromTo("#ticket", { scale: 1 }, { keyframes: [{ scale: 1.07, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }], svgOrigin: "540 700" }, C.p742 - 0.05);
      D.blurIn("#h-kick", C.mais - 0.05);
      D.glow("amber", C.film, 0.2, 0.4); D.glow("red", C.film, 0.5, 0.4);
      D.stamp("#h-stamp span", C.moitie, -5);
      D.shake(C.moitie + 0.02, 10);
      D.flash(C.moitie + 0.02, 0.16);
      // le billet devient la barre
      D.blurOut(["#h-t1", "#h-kick", "#h-stamp span"], C.alors - 0.1, 0.15);
      tl.to("#ticket", { x: -285, y: 120, scale: 0.5, opacity: 0, svgOrigin: "540 700", duration: 0.4, ease: "power3.inOut" }, C.alors - 0.1);
      D.glow("red", C.alors, 0, 0.4); D.glow("amber", C.alors, 0.15, 0.4); D.glow("cream", C.alors, 0.45, 0.4);

      // ================= 2. QUI PREND QUOI =================
      tl.fromTo("#ptag", { opacity: 0, y: 60, scale: 0.8 }, { opacity: 1, y: 0, scale: 1, duration: 0.4, ease: "expo.out" }, C.alors + 0.15);
      tl.fromTo("#bar", { opacity: 0, y: 140, filter: "blur(10px)" }, { opacity: 1, y: 0, filter: "blur(0px)", duration: 0.45, ease: "expo.out" }, C.alors + 0.1);
      tl.fromTo("#bar .sl", { scaleX: 0, transformOrigin: "0% 50%" }, { scaleX: 1, duration: 0.3, stagger: 0.06, ease: "power3.out" }, C.qui);

      // l'État : TVA
      tl.to("#sl-tva", { backgroundColor: "#ece6d6", duration: 0.25 }, C.letat - 0.1);
      tl.fromTo("#sl-tva", { x: 0 }, { keyframes: [{ x: 26, duration: 0.15 }, { x: 0, duration: 0.3, ease: "expo.out" }] }, C.letat - 0.1);
      D.blurIn("#l-tva", C.letat - 0.1);
      D.blurIn("#l-tva .val", C.c39 - 0.12, 0.16);
      D.count("v-tva", 0, 0.39, C.c39 - 0.1, 0.8);
      // la taxe CNC
      tl.to("#sl-cnc", { backgroundColor: "#4cc4ff", duration: 0.25 }, C.c75 - 0.1);
      tl.fromTo("#sl-cnc", { x: 0 }, { keyframes: [{ x: 26, duration: 0.15 }, { x: 0, duration: 0.3, ease: "expo.out" }] }, C.c75 - 0.1);
      D.glow("cold", C.c75, 0.4, 0.4);
      D.blurIn("#l-cnc", C.c75 - 0.1);
      D.blurIn("#l-cnc .val", C.c75 - 0.05, 0.16);
      D.count("v-cnc", 0, 0.75, C.c75, 0.8);
      // il reste 6,28 €
      tl.to(["#l-tva", "#l-cnc"], { opacity: 0, filter: "blur(8px)", duration: 0.25 }, C.reste - 0.25);
      tl.to(["#sl-tva", "#sl-cnc"], { opacity: 0.35, duration: 0.3 }, C.reste - 0.1);
      D.count("p-num", 7.42, 6.28, C.reste, C.p628 - C.reste + 0.5);
      tl.fromTo("#ptag", { scale: 1 }, { keyframes: [{ scale: 1.1, duration: 0.09 }, { scale: 1, duration: 0.35, ease: "expo.out" }] }, C.p628 + 0.4);
      // la Sacem
      tl.to("#sl-sac", { backgroundColor: "#ece6d6", duration: 0.25 }, C.sacem - 0.1);
      tl.fromTo("#sl-sac", { x: 0 }, { keyframes: [{ x: 26, duration: 0.15 }, { x: 0, duration: 0.3, ease: "expo.out" }] }, C.sacem - 0.1);
      D.blurIn("#l-sac", C.sacem - 0.1);
      D.blurIn("#l-sac .val", C.c10 - 0.12, 0.16);
      D.count("v-sac", 0, 0.1, C.c10 - 0.1, 0.6);
      D.count("p-num", 6.28, 6.18, C.c10, 0.6);
      tl.to("#l-sac", { opacity: 0, filter: "blur(8px)", duration: 0.25 }, C.reste2 - 0.2);
      tl.to("#sl-sac", { opacity: 0.35, duration: 0.3 }, C.reste2 - 0.1);
      // le partage : salle et distributeur
      D.glow("cold", C.reste2, 0, 0.4);
      tl.to("#sl-sal", { backgroundColor: "#ff5236", duration: 0.3 }, C.salle - 0.1);
      tl.to("#sl-dis", { backgroundColor: "#ffb21f", duration: 0.3 }, C.distributeur - 0.1);
      tl.fromTo("#sl-dis", { y: 0 }, { keyframes: [{ y: -12, duration: 0.12 }, { y: 0, duration: 0.3 }] }, C.distributeur - 0.1);
      tl.fromTo("#sl-sal", { y: 0 }, { keyframes: [{ y: 12, duration: 0.12 }, { y: 0, duration: 0.3 }] }, C.salle - 0.1);
      D.glow("red", C.salle2, 0.45, 0.4);
      D.blurIn("#l-sal", C.salle2 - 0.1);
      D.blurIn("#l-sal .val", C.p322 - 0.12, 0.16);
      D.count("v-sal", 0, 3.22, C.p322 - 0.1, 1.0);
      tl.to("#pc-sal", { opacity: 1, duration: 0.25 }, C.p322 + 0.8);
      D.glow("amber", C.distributeur2, 0.5, 0.4);
      D.blurIn("#l-dis", C.distributeur2 - 0.1);
      D.blurIn("#l-dis .val", C.p296 - 0.12, 0.16);
      D.count("v-dis", 0, 2.96, C.p296 - 0.1, 1.0);
      tl.to("#pc-dis", { opacity: 1, duration: 0.25 }, C.p296 + 0.8);
      D.popIn("#cd1", C.pub - 0.05, 0.5);
      D.popIn("#cd2", C.producteur - 0.05, 0.5);
      tl.fromTo("#l-dis .val", { scale: 1, transformOrigin: "0% 50%" }, { keyframes: [{ scale: 0.92, duration: 0.12 }, { scale: 1, duration: 0.35 }] }, C.producteur + 0.2);

      // ================= BONUS : la taxe finance les films français =================
      tl.to(["#ptag", "#bar", ".label", "#ch-dis"], { opacity: 0, filter: "blur(10px)", duration: 0.3 }, C.fou - 0.3);
      D.glow("red", C.fou, 0, 0.4); D.glow("amber", C.fou, 0, 0.4); D.glow("cold", C.fou, 0.55, 0.4);
      D.blurIn("#b-num", C.c75b - 0.1);
      tl.fromTo("#b-num", { scale: 0.7 }, { scale: 1, duration: 0.35, ease: "back.out(2)" }, C.c75b - 0.1);
      D.blurIn("#b-sub", C.taxe2 - 0.1);
      { const ln = document.getElementById("b-line"); ln.style.strokeDasharray = 120; ln.style.strokeDashoffset = 120; }
      tl.to("#b-line", { strokeDashoffset: 0, duration: 0.35, ease: "power2.out" }, C.financer - 0.1);
      tl.to("#b-head", { opacity: 1, duration: 0.1 }, C.financer + 0.2);
      tl.fromTo("#b-card", { opacity: 0, y: 40, scale: 0.9 }, { opacity: 1, y: 0, scale: 1, duration: 0.4, ease: "back.out(2)" }, C.films - 0.1);
      D.flash(C.francais, 0.12, "#4cc4ff");
      D.popIn("#bc1", C.blockbuster - 0.1, 0.5);
      D.glow("red", C.americain, 0.3, 0.4);

      // ================= CHUTE : le pop-corn =================
      tl.to(["#b-num", "#b-sub", "#b-arrow", "#b-card", "#b-chip"], { opacity: 0, filter: "blur(10px)", duration: 0.25 }, C.popcorn - 0.35);
      D.glow("cold", C.popcorn - 0.2, 0, 0.4); D.glow("cream", C.popcorn - 0.2, 0.2, 0.4); D.glow("amber", C.popcorn - 0.2, 0.5, 0.4);
      tl.fromTo("#tw-title .wsp", { opacity: 0, filter: "blur(8px)" }, { opacity: 1, filter: "blur(0px)", duration: 0.14, stagger: 0.08, ease: "power2.out" }, C.et_pop - 0.1);
      tl.fromTo("#pop", { opacity: 0, y: 120 }, { opacity: 1, y: 0, duration: 0.45, ease: "back.out(1.8)" }, C.popcorn - 0.05);
      tl.fromTo("#kern circle", { scale: 0, transformOrigin: "50% 50%" }, { scale: 1, duration: 0.3, stagger: 0.04, ease: "back.out(3)" }, C.popcorn + 0.15);
      D.stamp("#tw-stamp span", C.pas, -5);
      D.shake(C.pas + 0.02, 12);
      D.glow("red", C.pas, 0.55, 0.3);
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
