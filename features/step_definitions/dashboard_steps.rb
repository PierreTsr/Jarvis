#require "support/inject_session"

categories = %w[Groceries Hardware Restaurants Banks]

Then /I should see all the categories/ do
  categories.each do |cat|
    steps %Q{Then I should see "#{cat}"}
  end
end

Given /I am in "(.*)"/ do |location|
  page.set_rack_session(zip_code: location)
end
