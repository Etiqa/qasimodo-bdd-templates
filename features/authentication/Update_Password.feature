Feature: Update password
  As a User
  I want to be able to update my password
  So that I can keep my account secure

  The user should be forced to use a secure password:
  more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z],
  one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].

  Scenario: User should be required to insert current password
  Current password is required for security reason
    Given I am logged user
    When I request to update password
    Then I should be requested to insert my current password

  Scenario Outline: Old password validation - "<PASSWORD>" password
    Given I am a user
    And I have requested to update my password
    And I have been requested to insert my current password
    When I insert "<PASSWORD>" password
    Then I should "<STATUS>" to continue updating my password

    Examples:
      | PASSWORD | STATUS      |
      | Correct  | be able     |
      | Wrong    | not be able |

  Scenario: Updating password successfully
    Given I am a logged user
    And I am updating my password
    And I have inserted my current password
    When I insert my new password twice
    And the passwords match
    Then password should be updated
    And I should see a success message like:
    """
    Password has been successfully updated!
    """

  Scenario: Updating password unsuccessful - Passwords not matching
    Given I am a logged user
    And I am updating my password
    And I have inserted my current password
    When I insert my new password twice
    And the passwords do not match
    Then password should not be updated
    And I should see an error message like:
    """
    Your password and confirmation password do not match.
    """

  Scenario Outline: Password Update notification via "<CHANNEL>"
    Given I am a User
    When I update my password
    Then I should receive a notification to my "<CHANNEL>"

    Examples:
      | CHANNEL |
      | Email   |
      | Phone   |

  Scenario: Login with updated password
    Given I am a User
    And I have updated my account password
    And I am on "sign in" page
    When I login with my updated password
    Then I should be logged in

  Scenario: Login with old password
    Given I am a User
    And I have updated my account password
    And I am on "sign in" page
    When I login with old password
    Then I should not be able to login
    And I should see an error message


  Scenario Outline: The new password must be secure: "<TYPE OF ERROR>"
    Given I am User
    When I try to update my password to "<PASSWORD>"
    Then I see an error message:
    """
    Your password must include at least: 8 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
    """
    And my password should not be updated

    Examples:
      | TYPE OF ERROR         | PASSWORD |
      | Missing Lower Case    | P@SSW0RD |
      | Missing Upercase Case | p@ssw0rd |
      | Missing Special Char  | Passw0rd |
      | Missing Number        | P@ssword |
      | Less Than 8 char      | P@ssw0r  |


