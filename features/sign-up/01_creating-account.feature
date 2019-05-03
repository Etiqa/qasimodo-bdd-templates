Feature: Creating QAsimodo Account
  As Lauren the Tester
  I want to create a QAsimodo account by entering email address and password
  so that I am able to start using QAsimodo

  Make sure:
  - Email address and password are the account credentials
  - It's possible to access to QAsimodo with new account credentials
  - It's not possible to have multiple account with the same Email address (identity information)
  - Verification Email is sent to the User Email address (User is able to verify the Email address)
  - Password cannot be set until Email address has been verify
  - Password is required twice before is set to avoid mistyping (Password is set only if both password match)
  - Password follow security standards: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
  - User is redirected to QAsimodo sign in page once the account credentials has been created

  Scenario: Creating account credentials successful
    Given I am Lauren the Tester
    And my Email address is "lauren@example.com"
    And my Email address is not associated with a QAsimodo account
    When I validate my Email address
    And I correctly set a password that follow the standard
    Then my account credentials should be created
    And I should be redirected to QAsimodo sign in page

  Scenario: Users should be able to access to QAsimodo with new credentials
    Given I am Lauren the Tester
    And I have created a new account with the following credentials:
      | Email              | Password  |
      | lauren@example.com | P@ssw0rd! |
    When I login with my new credentials
    Then I should be logged into QAsimodo

  Scenario: Creating account credentials unsuccessful - Email address already registered
    Given I am Lauren the Tester
    And I have a valid QAsimodo account with the following credential:
      | Email Address      |
      | lauren@example.com |
    When I try to create a new account with "lauren@example.com" email address
    Then I should not be able to create a new account

  @usability @security
    # Usability because deals with mistyping. Security because prevents some simple bots
  Scenario: Users should be able to verify they email address
    Given I am Lauren the Tester
    And my Email address is "lauren@example.com"
    And my Email address is not associated with a QAsimodo account
    When I submit my Email address to create a new account
    Then I should receive a "Verification" email to my Email Address
    And I should be able to verify my Email address

  @security
  Scenario Outline: The new password must be secure: <TYPE OF ERROR>
    Given I am Lauren the Tester
    And I have verified my Email address
    But I have not yet set a password for my new account
    When I submit the following password with <TYPE OF ERROR>
      | New Password | Confirm New Password |
      | <PASSWORD>   | <PASSWORD>           |
    Then I should not be able to set my password
    And I should get an error message as:
    """
    Your password must be secure: Include 8 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
    """

    Examples:
      | TYPE OF ERROR            | PASSWORD |
      | Missing a Lower Case     | P@SSW0RD |
      | Missing an Upercase Case | p@ssw0rd |
      | Missing a Special Char   | Passw0rd |
      | Missing a Number         | P@ssword |
      | Less Than 8 char         | P@ssw0r  |


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
    New password and Confirm new password must match!.
    """






































