json.array!(@bookings) do |booking|
  json.extract! booking, :id, :instructor_id
  json.start booking.start_time  
  json.end booking.end_time
  json.url instructor_availability_url(@instructor, booking, format: :html)
end