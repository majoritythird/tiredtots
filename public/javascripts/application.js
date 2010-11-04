jQuery(document).ready(function($) {

  $('.sleep_blocks a#pager').live('click', function(event) {
    event.preventDefault();
    $.get($(this).attr('href'), function(json) {
      $('.sleep_blocks .days').append(json.html);
      $('.sleep_blocks .actions').replaceWith(json.link);
    }, 'json');
  });

});
