
Given /I answer all the questions with:(.*),(.*),(.*),(.*),(.*),(.*)/ do |from_country, address, work, budget, latitude, longitude|
  steps %Q{
    Given I fill in "country" with "#{from_country}"
    And I fill in "city" with "#{address}"
    And I fill in "work" with "#{work}"
    And I fill in "budget" with "#{budget}"
    And I fill in "user_latitude" with "#{latitude}"
    And I fill in "user_longitude" with "#{longitude}"
  }
end