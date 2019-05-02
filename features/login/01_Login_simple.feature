Feature: Login into QAsimodo - Simple Example
  As a Mark the Tester
  I want to be able to login in QAsimodo
  So that I am able to use the Application

  Make sure:
  - Username and password are mandatory to login
  - Registered users are able to login
  - Unregistered users are not able to login

  Scenario: Login successful
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | P@ssword |
    When I correctly submit my account credentials
    Then I should be logged in
