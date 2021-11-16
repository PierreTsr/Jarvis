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

  Given I follow "groceries"
  Then I should see "Westside Market"

Scenario: do not display negative results for "groceries"

  Given I follow "groceries"
  Then I should not see "University Hardware store"

Scenario: filter to find cheapest results positive
  Given I follow "groceries"
  When I check "$"
  And I press "Refresh"
  Then I should see "Hamilton Deli"

Scenario: filter to find cheapest results negative 
  Given I follow "groceries"
  When I check "$$"
  And I uncheck "$"
  And I uncheck "$$$"
  And I uncheck "$$$$"
  And I press "Refresh"
  Then I should not see "New Chelsea Market"

Scenario: filter to find highest rating positive
  Given I follow "groceries"
  When I check "3.0"
  And I uncheck "1.0"
  And I uncheck "2.0"
  And I uncheck "5.0"
  And I uncheck "4.0"
  And I press "Refresh"
  Then I should see "H Mart"

Scenario: filter to find highest rating negative
  Given I follow "groceries"
  When I check "4.0"
  And I uncheck "1.0"
  And I uncheck "2.0"
  And I uncheck "3.0"
  And I uncheck "5.0"
  And I press "Refresh"
  Then I should not see "CTown Supermarkets"