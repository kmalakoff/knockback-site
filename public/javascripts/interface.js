$(function(){
  var languages = ['cs','js'];
  var codestyle = $('.selection.codestyle');

  // bind all
  codestyle.on('change', 'input', function(){
    var now = codestyle.find('input:checked');
    var language = now.val();
    for (var i = 0, l = languages.length; i<l; ++i) {
      var lang = languages[i];
      $('[data-for="'+lang+'"]')[ lang === language ? 'show' : 'hide' ]();
    }
  });

  // initial state
  codestyle.find('.auto').removeClass('auto').click();
});