categories = %w[Groceries Hardware Restaurants Banks]

Then /I should see all the categories/ do
  categories.each do |cat|
    steps %Q{Then I should see "#{cat}"}
  end
end

Given /I am in "(.*)"/ do |location|
  user = User.find(session[:user])
  user.to_city = location
end
