<% if @booking.errors.any? %>
  <% @booking.errors.full_messages.each do |error| %>
    alert("<%= error %>" );
  <% end %>
<% else %>
  $('.Icalendar').fullCalendar('refetchEvents');
  $('#bookingModal').modal('hide')
<% end %>
