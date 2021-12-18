Feature: ask questions to the user and redirect it to the dashboard

  As a new-comer in NYC
  So that I can have customized recommendations
  I want to fill in the required information and access my dashboard

Background: on the question page, un-authenticated

  Given I am on the Questions page
  And I am not authenticated

  Scenario: ask questions on the question page

    Then I should see "Which country are you coming from?"
    And I should see "Which city are you traveling to?"
    And I should see "What is your work category?"
    And I should see "What is your budget?"

  Scenario: answer questions and redirect to the Dashboard

    Given I answer all the questions with:France,1000 5th Ave New York,student,2,40.72273293527885,-74.00360957704073
    Given I uncheck "create_account"
    Given I press "Get Recommendations"
    Then I should be on the Category page

  Scenario: missing answer
  
    Given I answer all the questions with:France,,student,2,,
    Given I press "Get Recommendations"
    Then I should be on the Questions page
