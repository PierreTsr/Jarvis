Feature: ask questions to the user and redirect it to the dashboard

  As a new-comer in NYC
  So that I can have customized recommendations
  I want to fill in the required information and access my dashboard

Background: on the landing page, un-authenticated

  Given I am on the Landing page
  And I am not authenticated

Scenario: ask questions on the landing page

  Then I should see "Origin Country"
  And I should see "Destination City"
  And I should see "Work Category"
  And I should see "Budget"

Scenario: answer questions and redirect to the Dashboard

  Given I answer all the questions
  And I click on "Submit"
  Then I should be on the Dashboard page

Scenario: missing answer

  Given I answer: France, , Student, 2
  And I click on "Sbumit"
  Then I should be on the Landing page
  And I should see "Please fill in all the questions before proceeding to the dashboard"

Scenario: unknown city

  Given I answer: France, abcd, Student, 2
  And I click on "Submit"
  Then I should be on the Landing page
  And I should see "Sorry, we cannot find this city"