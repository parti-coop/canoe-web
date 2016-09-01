//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require trianglify
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require rails-timeago
//= require locales/jquery.timeago.ko
//
// unobtrusive_flash
UnobtrusiveFlash.flashOptions['timeout'] = 30000;

$(document).on('ready', function() {
  var pattern = Trianglify({
    width: 1200,
    height: 600,
  });
  $('.pattern-trianglify').css("background-image", "url('" + pattern.png() + "')");
});
