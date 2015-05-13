	
var ready = function() {
	

	// build the language selector's options
	$.each($.fullCalendar.langs, function(langCode) {
		$('#lang-selector').append(
			$('<option/>')
				.attr('value', langCode)
				.prop('selected', langCode == currentLangCode)
				.text(langCode)
		);
	});

	// rerender the calendar when the selected option changes
	$('#lang-selector').on('change', function() {
		if (this.value) {
			currentLangCode = this.value;
			$('.calendar').fullCalendar('destroy');
			renderCalendar();
		}
	});
}

$(document).ready(ready);
$(document).on('page:load', ready);
