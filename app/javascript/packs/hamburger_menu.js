document.addEventListener('turbolinks:load', function () {
  $('#js-hamburger-menu').on('click', function() {
    $('.navigation').slideToggle(500)
    // ('.hamburger-menu').toggleClass('hamburger-menu-open')
  });
});