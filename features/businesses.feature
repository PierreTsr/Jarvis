Feature: See correct businesses according to the category selected

Scenario: See all categories on Dashbard
Given I am authenticated
And I am on the Dashboard
Then I should see all categories

Scenario: Businesses for that category should be visible
Given I am authenticated
Given I am on the Dashboard
Given I am in Morningside Heights
And I click on Groceries
Then I should see University Hardware Store

Scenario: Businesses which do not belong to the selected category should not be visible
Given I am authenticated
Given I am on the Dashboard
Given I am in Morningside Heights
And I click on Groceries
Then I should not see University Hardware Store

Scenario: Clicking on a business should open that businesses' page
Given I am authenticated
Given I am on the Dashboard
Given I am in Morningside Heights
Given I click on Groceries
Given I click on Westside Market
Then I redirect to Westside Market page
And I should see Westside Market