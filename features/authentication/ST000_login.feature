Feature: Login
  As a user
  I want to be able to login to QAsimodo
  So that I access to my personal account

  Scenario: Login successfully
    Given a user is registered in the system
    When the user authenticate with the system
    Then the user should be logged in



  Scenario: Login unsuccessful - Account does not exist
    Given a user is not registered in the system
    When the user authenticate with the system
    Then the user should not be logged in
    And the user should see an error message


  Scenario: Login unsuccessful - Wrong Credentials

  Scenario: Login unsuccessful - Missing Credentials
    Given I am a user
    When I try to sign in missing authentication information
    Then I should not be able to login
    And I should see an error message