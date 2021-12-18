Given /I answer all the questions with:(.*),(.*),(.*),(.*),(.*),(.*)/ do |from_country, address, work, budget, latitude, longitude|
  steps %Q{
    Given I select "#{from_country}" from "country"
    And I fill in "city" with "#{address}"
    And I choose "user_work_#{work}"
    And I choose "user_budget_#{budget}"
    And I fill in "user_latitude" with "#{latitude}"
    And I fill in "user_longitude" with "#{longitude}"
  }
end

When /^I submit the "([^\"]*)" form$/ do |form_id|
  # find('input[name="commit"]').click
  # element = find_by_id(form_id)
  # Capybara::RackTest::Form.new(page.driver, element.native).submit :name => nil
end

# When /^I submit the form$/ do
#   page.evaluate_script("document.forms[0].submit()")
# end

# Given I fill in "country" with "#{from_country}"
# And I fill in "work" with "#{work}"
# And I fill in "budget" with "#{budget}"

