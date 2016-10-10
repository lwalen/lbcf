var verses = {};
var currentRef = null;

var mainColor = '#F9F7F3';
var secondaryColor = '#FF5750';

$(function() {
	$.getJSON('verses.json', function(data) {
		verses = data;
	});

	$('.ref').on('mouseover', function() {
		if ($(this)[0] !== $(currentRef)[0]) {
			$(this).css('background-color', mainColor);
		}

		showVerses(this);
	});

	$('.ref').on('mouseout', function() {
		if ($(this)[0] !== $(currentRef)[0]) {
			unHighlight(this);
		}

		if (currentRef) {
			showVerses(currentRef);
		} else {
			clearVerses();
		}
	});

	$('.ref').on('click', function() {
		if (currentRef) {
			unHighlight(currentRef);
		}

		$(this).css('background-color', secondaryColor);
		$(this).css('color', mainColor);

		currentRef = $(this);
	});
});

function showVerses(ele) {
	var id = getParagraphID(ele);
	var refs = $(ele).data('verses').split(';')
	var content = "";

	refs.forEach(function(ref) {
		ref = ref.trim();
		if (ref === "") {
			return;
		}

		if (verses[ref]) {
			content += "<h4>" + ref + "</h4>";
			content += "<p>" + verses[ref] + "</p>";
		} else {
			console.log("Missing verse content for " + ref)
		}
	});

	var pattern = /chapter-([0-9]+)-paragraph-([0-9]+)/g;
	var section_name = id.replace(pattern, 'Chapter $1, Paragraph $2');
	$('.side .ref-link').html("<a href='#" + id + "'>" + section_name + "</a>");
	$('.side .content').html(content);
}

function clearVerses() {
	$('.side .ref-link').html("");
	$('.side .content').html("");
}

function unHighlight(ele) {
	$(ele).css('background-color', '');
	$(ele).css('color', '');
}

function getParagraphID(ele) {
	return $(ele).parent().find('.paragraph-number').attr('id');
}
