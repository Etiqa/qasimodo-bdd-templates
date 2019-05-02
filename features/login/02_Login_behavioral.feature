# Behavioral Approach of Login feature. Just Functional Requirements
Feature: Login into QAsimodo - Behavioral
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
      | Mark     | Pass     |
    When I correctly submit my account credentials
    Then I should be logged in

  Scenario: Login unsuccessful - Account does not exist
    Given I am Lauren the Tester
    And I do not have an account on QAsimodo
    When I try to login guessing credentials
    Then I should not be able to login