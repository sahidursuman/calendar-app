# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "admin@123.com",
    password: "123123",
    first_name: "admin",
    last_name: "admin",
    admin: true,
)
u.skip_confirmation!
u.save!

# Test user 
u = User.new(
    first_name: "test",
    last_name: "user",
    email: "testuser@123.com"
    password: "123123",
    time_zone: Faker::Address.time_zone
)
u.skip_confirmation!
u.save!

# Test user accounts
100.times do |i|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
  u = User.new(
  		first_name: first_name,
  		last_name: last_name,
      email: first_name.chr.downcase + last_name.chr.downcase + "#{i}@123.com",
      password: "123123",
      time_zone: Faker::Address.time_zone
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)
end

education_levels = ["Bachelor Degree", "Master Degree", "PhD", "Other"]

50.times do

	instructor_user = User.all.sample
	Instructor.create!(
  teacher_id: User.all.sample.id, 
  description: Faker::Lorem.paragraphs(paragraph_count=3).join(" "),
  country_of_origin: Faker::Address.country,
  first_language: "English",
  subject_to_teach: "English",
  education: education_levels.sample,
  price_cents: rand(1000...4000),
  skype: "#{instructor_user.first_name}_#{rand(1..42)}"
	)

	print "|"

end
