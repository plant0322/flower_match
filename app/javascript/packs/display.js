document.addEventListener('DOMContentLoaded', function () {
  const target = document.querySelectorAll('.js-display-target');

  const options = {
    root: null,
    rootMargin: '-20% 0px',
    threshold: 0,
  };

  const observer = new IntersectionObserver(callback, options);
  target.forEach((tgt) => {
    observer.observe(tgt);
  });

  function callback(entries) {
    entries.forEach((entry) => {
      const target = entry.target;
      if (entry.isIntersecting) {
        target.classList.add('js-display-is-active');
      }
    });
  }

});