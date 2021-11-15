
Given /I answer all the questions with:(.*),(.*),(.*),(.*)/ do |from_country, to_city, work, budget|
  steps %Q{
    Given I fill in "country" with "#{from_country}"
    And I fill in "city" with "#{to_city}"
    And I fill in "work" with "#{work}"
    And I fill in "budget" with "#{budget}"
  }
end