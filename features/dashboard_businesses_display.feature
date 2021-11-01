Feature: choose a category and see relevant recommendation

  As a new comer in Morningside-Heights who has answered the questions
  So that I can have the best experience in my neighborhood
  I should see relevant recommendations for the categories I select

Background:

  Given I am on the Dashboard page
  And my profile is known

Scenario: display all the categories

  Then I should see all the categories

Scenario: display positive results for "Groceries"

  Given I click on Groceries
  And I am in Morningside Heights
  Then I should see Westside Market

Scenario: do not display negative results for "Groceries"

  Given I click on Groceries
  Then I should not see University Hardware store