def create_user(country, city, work, budget)
	@test_user = User.new(name: "Jacques", email: "jacques@test.com", password: "lololo", from_country: country,
						  to_city: city, work: work, budget: budget)
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