$(document).on('ready page:load', function() {

	var calendar = $('.calendar'),
	userId = calendar && calendar.data('user-id');

	 function generateCalendar(){ 
		calendar.fullCalendar({
		header: {
			left: 'title',
			center: 'prev next',
			right: 'today month,agendaWeek,agendaDay' 
		},
		
		defaultView: "agendaWeek",

		lang: currentLangCode,
		weekNumbers: true,
		displayEventEnd: true,
		eventLimit: true,
		eventOverlap: false,
		overlap: false,
		eventSources: [{
			url: '/users/' + userId + '/availabilities.json',
			// rendering: 'background',
			rendering: 'background', 
			color: '#6AA4C1',
		}],
	});
};

generateCalendar();

	var currentLangCode = 'en';
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
			generateCalendar();
		}
	});	

});
