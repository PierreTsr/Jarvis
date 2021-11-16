def create_user(country, city, work, budget)
	@test_user = User.new(name: "Pierre", from_country: "France", address: "1000 5th Ave, New York", work: "student", budget: 2, email: "test@mail.com", password: "lalala", zip_code: 10028, latitude: 40.779079, longitude: -73.962578)
end

def sign_out
	if page.has_content?("Sign Out")
		click_link("Sign Out")
	end
end

def sign_in(country, city, work, budget)
	@test_user = create_user country, city, work, budget
	@test_user.save!
	sign_out
	click_link("Sign In")
	fill_in "Email", with: @test_user.email
	fill_in "Password", with: @test_user.password
end

Given /^I am authenticated$/ do
	sign_in "France", "10025", "student", 2
end

Given /^I am authenticated with: "(.*)", "(.*)", "(.*)", "(.*)"$/ do |country, city, work, budget|
	sign_in country, city, work, budget
end

Given /^I am not authenticated$/ do
	sign_out
end

Given /^I have an account with email: "(.*)" and password: "(.*)"$/ do |email, password|
	@test_user =  create_user"France", "10025", "student", 2
	@test_user.email = email
	@test_user.password = password
	@test_user.save!
end