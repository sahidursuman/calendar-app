json.array!(@repeatings) do |repeating|
  json.extract! repeating, :id, :instructor_id
  json.start repeating.start_time  
  json.end repeating.end_time
  json.dow repeating.days_of_the_week
  json.url instructor_availability_url(@instructor, repeating, format: :html)
end