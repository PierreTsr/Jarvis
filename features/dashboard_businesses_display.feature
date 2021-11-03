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