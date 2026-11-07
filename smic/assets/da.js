/* =====================================================================
   DA « … VRAIMENT ? » — gestes d'animation communs à toutes les vidéos.
   Usage dans un épisode :  const D = DA(tl);  D.blurIn("#x", 1.2); …
   ===================================================================== */
window.DA = function (tl) {
  const fr = (v, d) => v.toFixed(d).replace(".", ",").replace("-", "−");
  const D = {
    fr,
    // un chiffre qui défile puis s'arrête (1–1,6 s), chiffres tabulaires
    count(id, from, to, at, dur, d = 2, suffix = "") {
      const o = { v: from }, el = document.getElementById(id);
      tl.to(o, { v: to, duration: dur, ease: "power2.out", onUpdate: () => (el.textContent = fr(o.v, d) + suffix) }, at);
    },
    // arrivée par défaut : flou → net
    blurIn(sel, at, d = 0.2, extra = {}) {
      tl.fromTo(sel, { opacity: 0, filter: "blur(10px)" }, { opacity: 1, filter: "blur(0px)", duration: d, ease: "power2.out", ...extra }, at);
    },
    blurOut(sel, at, d = 0.15) {
      tl.to(sel, { opacity: 0, filter: "blur(10px)", duration: d, ease: "power2.in" }, at);
    },
    // une étiquette ou un objet qui se pose
    popIn(sel, at, from = 0.6) {
      tl.fromTo(sel, { opacity: 0, scale: from }, { opacity: 1, scale: 1, duration: 0.38, ease: "back.out(2.2)" }, at);
    },
    // le tampon rouge penché (2 par vidéo maximum)
    stamp(sel, at, rot = -5) {
      tl.fromTo(sel, { opacity: 0, scale: 2.3, rotation: rot - 9 }, { opacity: 1, scale: 1, rotation: rot, duration: 0.24, ease: "expo.out" }, at);
    },
    // secousse de caméra sur un impact (3 par vidéo maximum)
    shake(at, a = 12) {
      tl.to("#cam", { keyframes: [
        { x: a, y: -a * 0.6, duration: 0.035 }, { x: -a * 0.8, y: a * 0.5, duration: 0.035 },
        { x: a * 0.5, y: a * 0.4, duration: 0.035 }, { x: -a * 0.3, y: -a * 0.3, duration: 0.035 },
        { x: 0, y: 0, duration: 0.05 } ] }, at);
    },
    flash(at, o = 0.18, color = null) {
      if (color) tl.set("#flash", { backgroundColor: color }, at);
      tl.to("#flash", { keyframes: [{ opacity: o, duration: 0.03 }, { opacity: 0, duration: 0.35, ease: "power2.out" }] }, at);
    },
    // halo de couleur du décor (cream, red, amber, cold)
    glow(name, at, o = 1, d = 0.45) {
      tl.to("#gl-" + name, { opacity: o, duration: d, ease: "power2.inOut" }, at);
    },
    // décor continu : la grille dérive lentement
    drift(end) {
      tl.fromTo("#grid", { y: 0 }, { y: -160, duration: end, ease: "none" }, 0);
    },
    // sous-titres karaoké : un groupe à la fois, le mot dit s'allume
    captions(CAP) {
      CAP.forEach((g) => {
        tl.fromTo("#" + g.id, { opacity: 0, y: 16 }, { opacity: 1, y: 0, duration: 0.1, ease: "power2.out" }, g.start);
        g.w.forEach((w) => {
          const el = document.getElementById(w.id);
          const em = el.classList.contains("em");
          tl.to(el, { color: em ? "#ffb21f" : "#f6f4ee", duration: 0.06 }, w.t);
          tl.to(el, { keyframes: [{ scale: 1.09, duration: 0.05 }, { scale: 1, duration: 0.22, ease: "power3.out" }] }, w.t);
        });
        tl.to("#" + g.id, { opacity: 0, duration: 0.08, ease: "power2.in" }, g.end - 0.08);
        tl.set("#" + g.id, { visibility: "hidden" }, g.end);
      });
    },
    // carte de fin : titre de la série, bouton, épisode, source
    endCard(at, beat) {
      tl.fromTo("#c-title div", { opacity: 0, x: 120, filter: "blur(12px)" }, { opacity: 1, x: 0, filter: "blur(0px)", duration: 0.32, stagger: 0.08, ease: "expo.out" }, at);
      tl.fromTo("#c-btn span", { opacity: 0, scale: 0.5 }, { opacity: 1, scale: 1, duration: 0.42, ease: "back.out(2.4)" }, at + 0.35);
      tl.to("#c-btn span", { keyframes: [{ scale: 1.08, duration: 0.12 }, { scale: 1, duration: 0.4, ease: "expo.out" }] }, Math.max(beat, at + 0.8));
      tl.fromTo("#c-ep", { opacity: 0, y: 20 }, { opacity: 1, y: 0, duration: 0.3 }, at + 0.55);
      tl.fromTo("#c-src", { opacity: 0 }, { opacity: 1, duration: 0.4 }, at + 0.65);
    },
  };
  return D;
};

// ajuste chaque groupe de sous-titres à la largeur utile — à appeler AVANT de construire la timeline
window.DA.fitCaptions = function (CAP, maxW = 860) {
  CAP.forEach((g) => {
    const el = document.getElementById(g.id), inner = el.querySelector(".in");
    let fs = 66;
    while (inner.getBoundingClientRect().width > maxW && fs > 44) { fs -= 2; el.style.fontSize = fs + "px"; }
  });
};
