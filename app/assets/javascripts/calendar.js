$(document).on('ready page:load', function() {

	var Icalendar = $('.Icalendar'),

	instructorId = Icalendar && Icalendar.data('instructor-id');

	 function generateInstructorCalendar(){ 
		Icalendar.fullCalendar({
		header: {
			left: 'title',
			center: 'prev next',
			right: 'today agendaWeek' 
		},
		
		defaultView: "agendaWeek",
		contentHeight: "auto",

		lang: currentLangCode,
		weekNumbers: true,
		displayEventEnd: true,
		eventLimit: true,
		eventOverlap: false,
		overlap: false,
		eventSources: [
			{
				url: '/instructors/' + instructorId + '/availabilities',
				rendering: 'background',
				className: 'availability-color'
			},
			
			{
				url: '/instructors/' + instructorId + '/bookings',
				backgroundColor: '#9DD6F2',
				className: 'booking-color'
			}
		],
		dayClick: function(date, jsEvent, view) {

        $('#availabilityModal').modal('show');
    
    },
	});
};

var currentLangCode = 'en';
generateInstructorCalendar();

	// build the language selector's options
	$.each($.fullCalendar.langs, function(langCode) {
		var langText = langCode;

		switch(langCode) {
			case 'en':
				langText = 'English';
				break;
				
			case 'zh-cn':
				langText = '简体中文';
				break;

			case 'zh-tw':
				langText = '繁體中文';
				break;
		}
		
		$('#lang-selector').append(
			$('<option/>')
				.attr('value', langCode)
				.prop('selected', langCode === currentLangCode)
				.text(langText)
		);
	});
// $('#lang-selector > option[value="zh-cn"]').text('简体中文');

	// rerender the Icalendar when the selected option changes
	$('#lang-selector').on('change', function() {
		if (this.value) {
			currentLangCode = this.value;
			$('.Icalendar').fullCalendar('destroy');
			generateInstructorCalendar();
		}
	});	

});
