document.addEventListener('turbolinks:load', function () {
  $('#js-hamburger-menu').on('click', function() {
    $('.navigation').slideToggle(500)
  });
});