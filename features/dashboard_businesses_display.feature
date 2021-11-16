Feature: choose a category and see relevant recommendation

  As a new comer in Morningside-Heights who has answered the questions
  So that I can have the best experience in my neighborhood
  I should see relevant recommendations for the categories I select

Background:

  Given I am in "10025"
  Given I am on the Category page

Scenario: display all the categories

  Then I should see all the categories

Scenario: display positive results for "groceries"

  Given I follow "See Grocery Recommendations"
  Then I should see "Westside Market"

Scenario: do not display negative results for "groceries"

  Given I follow "See Grocery Recommendations"
  Then I should not see "University Hardware store"

Scenario: filter to find cheapest results positive
  Given I follow "See Grocery Recommendations"
  When I check "$"
  And I press "Refresh"
  Then I should see "Hamilton Deli"

# Scenario: filter to find cheapest results negative 
#   Given I follow "See Grocery Recommendations"
#   When I check "$"
#   And I press "Refresh"
#   Then I should not see "Morton Williams"

Scenario: filter to find highest rating positive
  Given I follow "See Grocery Recommendations"
  When I check "5.0"
  And I press "Refresh"
  Then I should see "Asia Market"

# Scenario: filter to find highest rating negative
#   Given I follow "See Grocery Recommendations"
#   When I check "5.0"
#   And I press "Refresh"
#   Then I should not see "Morton Williams"