$(function() {
  $('.ref').on('mouseover', function() {
    $(this).css('background-color', '#dddddd');
    $('.side').text($(this).data('verses'));
  });

  $('.ref').on('mouseout', function() {
    $(this).css('background-color', '');
    $('.side').text('');
  });
});
