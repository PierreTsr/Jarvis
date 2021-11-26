Feature: gives the user to see detailed information on a business and read reviews on it

  As a user who wants to find information on a business
  So that I can make a buying decision
  I want JARVIS to display detailed info 

Background:
  Given I am authenticated with: France, 1000 5th Ave New York, 10025, student, 2, 40.72273293527885, -74.00360957704073
  Given I am on the Category page


Scenario: display positive results for "restaurants"
  Given I follow "restaurants"
  And I follow "Nobody Told Me"
  Then I should be at the business page for: "Nobody Told Me"
  Then I should see "Working hours"
  And I should see "Reviews"
  And I should see "About the business"