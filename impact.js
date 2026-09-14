// Impact page — dashboard stat counter (reuses same pattern as homepage)
document.addEventListener('DOMContentLoaded', function () {
  var statEl = document.querySelector('.dash-number[data-count]');
  if (!statEl) return;

  var target = parseInt(statEl.getAttribute('data-count'), 10) || 0;
  var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function animateCount() {
    if (reduceMotion) { statEl.textContent = target; return; }
    var duration = 1200, start = null;
    function step(ts) {
      if (!start) start = ts;
      var progress = Math.min((ts - start) / duration, 1);
      statEl.textContent = Math.floor(progress * target);
      if (progress < 1) requestAnimationFrame(step);
      else statEl.textContent = target;
    }
    requestAnimationFrame(step);
  }

  if ('IntersectionObserver' in window) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) { animateCount(); observer.disconnect(); }
      });
    }, { threshold: 0.5 });
    observer.observe(statEl);
  } else {
    statEl.textContent = target;
  }
});
