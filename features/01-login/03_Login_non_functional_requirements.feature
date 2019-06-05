# Example: Adding Non Functional Requirements
Feature: Login into QAsimodo
  As Mark the Tester
  I want to be able to login in QAsimodo
  So that I am able to use the Application

  Make sure:
  - Username and password are mandatory to login
  - Registered users are able to login
  - Unregistered users are not able to login
  - Wrong authentication follow OWASP standards: System should answer in the same way for every failed attempt of authentication (Examples: wrong username, wrong password)
  - User is guided when both username and password credentials are missing

  Scenario: Successful Login
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | Pass     |
    When I correctly submit my account credentials
    Then I should be logged in

  Scenario: Unsuccessful Login - Unregistered User
    Given I am Lauren the Tester
    And I do not have an account on QAsimodo
    When I try to login guessing credentials
    Then I should not be able to login

  @security
  Scenario Outline: System should answer with a generic error message when Logging in with wrong "<CREDENTIAL>"
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | Pass     |
    When I login submitting wrong "<CREDENTIAL>"
    Then I should not be able to login
    And I should see an authentication error message as:
    """
    Username and/or Password are wrong!
    """

    Examples:
      | CREDENTIAL |
      | Username   |
      | Password   |

  @usability
  Scenario: Unsuccessful Login - Missing authentication credentials
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | Pass     |
    When I login without providing my credentials
    Then I should not be able to login
    And I should see message as:
    """
    Username and Password are mandatory to login
    """
