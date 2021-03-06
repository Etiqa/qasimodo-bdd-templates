Feature: Creating QAsimodo Account
  As Lauren the Tester
  I want to create a QAsimodo account by entering email address and password
  so that I am able to start using QAsimodo

  Make sure:
  - Email address and password are the account credentials
  - It's possible to access to QAsimodo with new account credentials
  - It's not possible to create new account credentials with an already existing Email address (identity information)
  - User is able to verify the Email address
  - Password cannot be set until Email address has been verified
  - Password is required twice before is set to avoid mistyping (Password is set only if both passwords match)
  - Password follows security standards: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
  - User is redirected to QAsimodo sign in page once the account credentials have been created

  Scenario: Successful account creation
    Given I am Lauren the Tester
    And my Email address is "lauren@example.com"
    And my Email address is not associated with a QAsimodo account
    When I validate my Email address
    And I correctly set a password that follows the standards
    Then my account credentials should be created
    And I should be redirected to QAsimodo sign in page

  Scenario: Users should be able to access to QAsimodo with new credentials
    Given I am Lauren the Tester
    And I have created a new account with the following credentials:
      | Email              | Password  |
      | lauren@example.com | P@ssw0rd! |
    When I login with my new credentials
    Then I should be logged into QAsimodo

  Scenario: Unsuccessful account creation - Email address already registered
    Given I am Lauren the Tester
    And I have a valid QAsimodo account with the following credentials:
      | Email Address      |
      | lauren@example.com |
    When I try to create a new account with "lauren@example.com" email address
    Then I should not be able to create a new account

  @usability @security
    # Usability because it deals with mistyping. Security because prevents some simple bots
  Scenario: User should be able to verify the email address
    Given I am Lauren the Tester
    And my Email address is "lauren@example.com"
    And my Email address is not associated as a QAsimodo account
    When I submit my Email address to create a new account
    Then I should be able to verify my Email address

  @usability
  Scenario: User must repeat new password to avoid mistyping
    Given I am Lauren the Tester
    And I have validated my Email address
    But I have not yet set a password for my new account
    When I submit the following information
      | New Password | Confirm New Password |
      | P@ssw0rd     | P@ssw0rd!            |
    Then I should not be able to set my password
    And I should get an error message as:
    """
    Passwords must match!
    """

  @security
  Scenario Outline: The new password must be secure: <TYPE OF ERROR>
    Given I am Lauren the Tester
    And I have verified my Email address
    But I have not yet set a password for my new account
    When I submit a "<TYPE OF ERROR>" password as:
      | New Password | Confirm New Password |
      | <PASSWORD>   | <PASSWORD>           |
    Then I should not be able to set my password
    And I should get an error message as:
    """
    Your password must be secure: Include 8 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
    """

    Examples:
      | TYPE OF ERROR        | PASSWORD |
      | Missing Lowercase    | P@SSW0RD |
      | Missing Uppercase    | p@ssw0rd |
      | Missing Special Char | Passw0rd |
      | Missing Number       | P@ssword |
      | Less Than 8 char     | P@ssw0r  |


