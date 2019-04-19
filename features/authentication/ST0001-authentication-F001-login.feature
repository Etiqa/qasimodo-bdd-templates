@login
Feature: Login into QAsimodo
  As Minimo the Tester
  I want to be able to login to QAsimodo
  So that I able to manage private testing session

  Scenario: Login successful
    Given I am Minimo the Tester
    And I have valid account on QAsimodo
    And a web browser is at QAsimodo login page
    When I submit my credentials
    Then the user should be logged in

  Scenario: Login unsuccessful - Wrong Credentials
    Given a web browser is at QAsimodo login page
    And the user is registered in the system
    When the user authenticates with wrong credentials
    Then the user should not be logged in
    And the user should see an error message


  Scenario: Login unsuccessful - Account does not exist
    Given a web browser is at QAsimodo login page
    And the user is not registered in the system
    When the user authenticates with the system
    Then the user should not be logged in
    And the user should see an error message


  Scenario: Login unsuccessful - Missing Credentials
    Given I am a user
    When I try to sign in missing authentication information
    Then I should not be able to login
    And I should see an error message