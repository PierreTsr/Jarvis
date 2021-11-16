def create_user(values)
	default_values = {name: "Pierre", from_country: "France", address: "1000 5th Ave, New York", work: "student", budget: 2, email: "test@mail.com", password: "lalala", zip_code: 10028, latitude: 40.779079, longitude: -73.962578}
	values = default_values.merge(values)
	@test_user = User.new values
end

def sign_out
	if page.has_content?("Sign Out")
		click_link("Sign Out")
	end
end

def sign_in(values)
	steps %Q{Given I am on the Home page}
	@test_user = create_user values
	@test_user.save!
	sign_out
	click_link("Sign In")
	fill_in "Email", with: @test_user.email
	fill_in "Password", with: @test_user.password
	click_button("Log in")
end

Given /^I am authenticated$/ do
	sign_in "France", "10025", "student", 2
end

Given /^I am authenticated with: (.*),(.*),(.*),(.*),(.*),(.*),(.*)/ do |from_country, address, zip_code, work, budget, latitude, longitude|
	values = {
		from_country: (from_country.strip unless from_country.strip.empty?), 
		zip_code: (zip_code.strip unless zip_code.strip.empty?), 
		address: (address.strip unless address.strip.empty?), 
		work: (work.strip unless work.strip.empty?), 
		budget: (budget.strip unless budget.strip.empty?), 
		latitude: (latitude.strip unless latitude.strip.empty?), 
		longitude: (longitude.strip unless longitude.strip.empty?)
	}
	values.delete_if{ |k,v| v.nil? }
	sign_in values
end

Given /^I am not authenticated$/ do
	sign_out
end

Given /^I have an account with email: "(.*)" and password: "(.*)"$/ do |email, password|
	@test_user =  create_user({email: email, password: password})
	@test_user.save!
end