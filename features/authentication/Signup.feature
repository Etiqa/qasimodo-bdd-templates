Feature: Sign up into Application
  As a New User
  I want to be able to register a new account
  So that I am able to use the Application

  Scenario: Account creation successful
    Given I am a User
    And I am on "Registration" page
    When I correctly submit all required registration information
    Then a new account should be created
    And I should see a success message
    And I should receive an "Account Creation Confirmation" email

  Scenario: Account creation unsuccessful - Missing information
    Given I am a User
    And I am on "Registration" page
    When I do not provide all required registration information
    Then a new account should not be created
    And I should see an error message
    And I should not receive an "Account Creation Confirmation" email

  Scenario: Account creation unsuccessful - Invalid information
    Given I am a User
    And I am on "Registration" page
    When I submit invalid registration information
    Then a new account should not be created
    And I should see an error message
    And I should not receive an "Account Creation Confirmation" email

  Scenario: User should be able to login after account creation
    Given I am a user
    And I have created an account successfully
    And I am on "Sign in" page
    When I submit my new credentials
    And I successfully complete MFA verification
    Then I should be logged in
    And I should be on the "Home" page


