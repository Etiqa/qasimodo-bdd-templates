Feature: Update password
  As a Lauren the Tester
  I want to be able to update my password
  So that I can keep my account secure

  Make sure:
  - Only logged users can request to update password
  - It's possible to access to QAsimodo with the updated password
  - It's not possible to access to QAsimodo with old password
  - Password cannot be updated until user provides the current password
  - Password follow security standards: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
  - Password is required twice before is reset to avoid mistyping (Password is reset only if both passwords match)

  Scenario: Updating password successfully
    Given I am Lauren the Tester
    And I am logged into QAsimodo
    When I request to update my password
    And I submit my current password
    And I correctly set a new password that follow the security standard
    Then the system should update my password

  Scenario: Users should be able to access to QAsimodo with the updated password
    Given I am Lauren the Tester
    And I have logged into QAsimodo with the following credentials
      | Email              | Password |
      | lauren@example.com | P@ssw0rd |
    When I update my password to:
      | New Password    |
      | updatedP@ssw0rd |
    Then I should be able to login into QAsimodo with "updatedP@ssw0rd" password

  Scenario: Users should not be able to access to QAsimodo with old password
    Given I am Lauren the Tester
    And I have logged into QAsimodo with the following credentials
      | Email              | Password |
      | lauren@example.com | P@ssw0rd |
    When I update my password to:
      | New Password    |
      | updatedP@ssw0rd |
    Then I should not be able to login into QAsimodo with "P@ssw0rd" password


  @security
  Scenario: Users must provide the current password to be able to update it
    Given I am Lauren the Tester
    And I am logged into QAsimodo with the following credentials:
      | Email              | Password |
      | lauren@example.com | P@ssw0rd |
    When I request to update my password
    And I submit the following information:
      | Current Password |
      | {Wrong Password} |
    Then I should not be able to update my password


  @usability
  Scenario: User must repeat new password to avoid mistyping
    Given I am Lauren the Tester
    And I am logged into QAsimodo
    And I have submitted my current password
    When I submit the following information
      | New Password | Confirm New Password |
      | P@ssw0rd     | P@ssw0rd!            |
    Then I should not be able to update my password
    And I should get an error message as:
    """
    Passwords must match!
    """

  @security
  Scenario Outline: The new password must be secure: <TYPE OF ERROR>
    Given I am Lauren the Tester
    And I am logged into QAsimodo
    And I have submitted my current password
    When I update my password to a "<TYPE OF ERROR>" password as:
      | New Password | Confirm New Password |
      | <PASSWORD>   | <PASSWORD>           |
    Then I should not be able to update my password
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


