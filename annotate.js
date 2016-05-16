var verses = {};
$(function() {
  $.getJSON('/verses.json', function(data) {
    verses = data;
  });

  $('.ref').on('mouseover', function() {
    $(this).css('background-color', '#dddddd');
    var refs = $(this).data('verses').split(';');
    var content = "";

    refs.forEach(function(ref) {
      ref = ref.trim();

      if (verses[ref]) {
        content += "<h4>" + ref + "</h4>";
        content += "<p>" + verses[ref] + "</p>";
      }
    });

    $('.side').html(content);
  });

  $('.ref').on('mouseout', function() {
    $(this).css('background-color', '');
    $('.side').text('');
  });
});
