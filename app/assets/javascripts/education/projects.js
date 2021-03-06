//= require js/plugins/jquery.sticky

$(document).ready(function () {
  effect();
  load_more();
  $('.page-title').sticky({topSpacing:0});
});

function effect() {
  $('ul[data-liffect] li').each(function (i) {
    $(this).attr('style', 'animation-delay:' + i * 100 + 'ms;');
    if (i === $('ul[data-liffect] li').size() -1) {
      $('ul[data-liffect]').addClass('play')
  }});
}

function load_more() {
  size = $('.load-more-project').length;
  x = 12;
  if(x >= size) {
    $('#more-project').hide();
    $('#next-project').show();
  }
  else {
    $('#next-project').hide();
    $('#more-project').show();
  };
  $('.load-more-project:lt(' + size + ')').hide();
  $('.load-more-project:lt(' + x + ')').show();
  $('.read-more').click(function () {
    x = (x <= size) ? x + 4 : size;
    $('.load-more-project:lt(' + x + ')').show();
    if(x >= size){
      $('#more-project').hide();
      $('#next-project').show();
      $("#back-project").show();
    }
  });
}
