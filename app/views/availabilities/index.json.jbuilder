json.array!(@availabilities) do |availability|
  json.extract! availability, :id, :start_time, :end_time, :user_id
  json.url availability_url(availability, format: :json)
end
