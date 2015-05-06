# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "ct@123.com",
    password: "123123",
    admin: true
)
u.skip_confirmation!
u.save!

# Test user accounts
50.times do |i|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
  u = User.new(
  		first_name: first_name,
  		last_name: last_name,
      email: first_name.downcase + last_name.downcase + "#{i}@123.com",
      password: "123123",
      time_zone: Faker::Address.time_zone
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end
