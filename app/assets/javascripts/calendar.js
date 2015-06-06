$(document).on('ready page:load', function() {

	var Icalendar = $('.Icalendar');
	var Ucalendar = $('.Ucalendar');

	var instructorId = Icalendar && Icalendar.data('instructor-id');
	var instructorId2 = Ucalendar && Ucalendar.data('instructor-id');
	var instructorTimeZone = Icalendar && Icalendar.data('instructor-timezone');
	var userTimeZone = Ucalendar && Ucalendar.data('user-timezone')


// This renders on the instructor side
	 function generateInstructorCalendar(){ 
		Icalendar.fullCalendar({
		header: {
			left: 'prev next',
			center: 'title',
			right: 'today' 
		},
		
		defaultView: "agendaWeek",
		contentHeight: "auto",
		timezone: 'instructorTimeZone',
		lang: currentLangCode,
		weekNumbers: false,
		displayEventEnd: true,
		eventLimit: true,
		editable: true,

		allDaySlot: false,
		eventOverlap: false,
		overlap: false,
		eventSources: [
			{
				url: '/instructors/' + instructorId + '/availabilities',
				rendering: 'background',
				className: 'availability-color',
				editable: true,
			},
			
			{
				url: '/instructors/' + instructorId + '/bookings',
				backgroundColor: '#9DD6F2',
				className: 'booking-color'
			}
		],
		// dayClick: function(date, jsEvent, view) {
  //     $('#availabilityModal').modal('show');
  //   },
	});
};

var currentLangCode = 'en';
generateInstructorCalendar();

	// This renders on the user side
	function generateUserCalendar(){ 
		Ucalendar.fullCalendar({
		header: {
			left: 'prev next',
			center: 'title',
			right: 'today' 
		},
		
		defaultView: "agendaWeek",
		contentHeight: "auto",

		lang: currentLangCode,
		weekNumbers: false,
		displayEventEnd: true,
		timezone: 'userTimeZone',
		eventLimit: true,
		allDaySlot: false,
		eventOverlap: false,
		overlap: false,
		eventSources: [
			{
				url: '/instructors/' + instructorId2 + '/availabilities',
				rendering: 'background',
				className: 'availability-color'
			},
			
			{
				url: '/instructors/' + instructorId2 + '/bookings',
				backgroundColor: '#9DD6F2',
				className: 'booking-color'
			}
		],
		dayClick: function(date, jsEvent, view) {
      $('#bookingModal').modal('show');
    },
	});
};

var currentLangCode = 'en';
generateUserCalendar();

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


	// rerender the Ucalendar when the selected option changes
	$('#lang-selector').on('change', function() {
		if (this.value) {
			currentLangCode = this.value;
			$('.Ucalendar').fullCalendar('destroy');
			generateUserCalendar();
			$('.Icalendar').fullCalendar('destroy');
			generateInstructorCalendar();
		}
	});

});
