Feature: gives the user to see detailed information on a business and read reviews on it

  As a user who wants to find information on a business
  So that I can make a buying decision
  I want JARVIS to display detailed info 

Background:
  Given I am authenticated with: France, 1000 5th Ave New York, 10025, student, 2, 40.7807561, -73.9698415
  Given I am on the Category page


Scenario: display positive results for "restaurants"
  Given I follow "restaurants"
  And I follow "The Penrose"
  Then I should be at the business page for: "The Penrose"
  Then I should see "Working hours"
  And I should see "Reviews"
  And I should see "Location"