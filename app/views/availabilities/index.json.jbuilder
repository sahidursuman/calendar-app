json.array!(@availabilities) do |availability|
  json.extract! availability, :id, :user_id
  json.start availability.start_time  
  json.end availability.end_time
  json.url user_availability_url(@user, availability, format: :html)
end