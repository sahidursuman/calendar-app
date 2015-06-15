 json.array!(@availabilities) do |availability|
  json.extract! availability, :id, :instructor_id
  json.start availability.start_time  
  json.end availability.end_time
  json.url instructor_availability_url(@instructor, availability, format: :html)
end