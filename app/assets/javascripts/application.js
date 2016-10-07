//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require trianglify
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require rails-timeago
//= require locales/jquery.timeago.ko
//= require jquery.webui-popover
//= require jquery.overlay
//= require jquery.textcomplete

// unobtrusive_flash
UnobtrusiveFlash.flashOptions['timeout'] = 30000;

$(document).on('ready', function() {
  var pattern = Trianglify({
    width: 1200,
    height: 600,
  });
  $('.pattern-trianglify').css("background-image", "url('" + pattern.png() + "')");
  $('[data-action="canoe-popover"]').webuiPopover();
  $('.action-emotion-textarea').each(function(i, elm) {
    var sign_values = $(elm).data('emotion-textarea-sign-values').split(" ")
    var sign_texts = $(elm).data('emotion-textarea-sign-texts').split(" ")
    styles = []
    for(i = 0; i < sign_values.length; i++) {
      styles.push({
        match: new RegExp("\\B:(" + sign_texts[i] + "):", "g"),
        klasses: "emotion emotion--" + sign_values[i]
      })
    }
    console.log(sign_texts);

    $(elm).textcomplete([{
        match: /\B:([ㄱ-ㅎ가-힣a-z0-9_]*)$/,
        search: function (term, callback) {
            var words = sign_texts;
            callback($.map(words, function (word) {
                return word.indexOf(term) === 0 ? word : null;
            }));
        },
        replace: function (value) {
            return ':' + value + ': ';
        },
        index: 1
    }], { maxCount: 100 }).overlay(styles);
  });
  $('.action-emotion-label').on('click', function(e) {
    e.preventDefault();
    var $target = $($(this).data('emotion-label-target'));
    $(this).blur();
    $target.focus();
    $target.val($target.val() + " :");
    setTimeout(function () {
        // Cursor is ready.
        $target.textcomplete('trigger', ':');
    }, 100);
  })
});

