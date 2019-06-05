# BAD EXAMPLE! This Feature is just to show how procedure-driven scenarios are written! Avoid writing scenarios like this
Feature: Login into QAsimodo - (Procedural Example)
  As Mark the Tester
  I want to be able to login in QAsimodo
  So that I am able to use the Application

  Make sure:
  - Username and password are mandatory to login
  - Registered users are able to login

  Scenario: Successful Login - (Procedural Example)
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | Pass     |
    When I open a web browser
    And I navigate to "https://{mydomain}.qasimodo.io"
    Then I should land on Qasimodo Sign In page
    When I enter "Mark" into the Username text field
    And I enter "Pass" into the Password text field
    And I click in "Login" button
    Then I should be logged in

