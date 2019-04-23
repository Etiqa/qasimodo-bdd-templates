Feature: Forgot password
  As a User
  I want to be able to reset my password
  So that I can use the Application even if I have forgot my current password

  Scenario: Request reset password for Existing Account
    Given I am a User
    And I have a valid account in the system
    But I have forgot my password
    When I request to reset password for my account
    Then I should be able to reset my account password

  Scenario: Request reset password for nonexistent Account
    Given I am a User
    When I request to reset password for a nonexistent account
    Then I should not be able to reset password

  Scenario: Setting new password successful - Password matching
    Given I am a User
    And I am resetting my password
    When I insert my new password twice
    And the passwords match
    Then password should be reset it
    And I should see a success message like:
    """
    Password has been successfully reset!
    """

  Scenario: Setting new password unsuccessful - Password not matching
    Given I am a User
    And I am resetting my password
    When I insert my new password twice
    And the passwords do not match
    Then password should not be reset it
    And I should see an error message like:
    """
    Your password and confirmation password do not match.
    """

  Scenario: Login with new password
    Given I am a User
    And I have reset my account password
    And I am on "sign in" page
    When I login with new password
    Then I should be logged in

  Scenario: Login with old password
    Given I am a User
    And I have reset my account password
    And I am on "sign in" page
    When I login with old password
    Then I should not be able to login
    And I should see an error message

  Scenario Outline: The new password must be secure: "<TYPE OF ERROR>"
    Given I am User
    When I try to update my password to "<PASSWORD>"
    Then I should see an error message:
    """
    Your password must include at least: 8 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
    """
    And my password should not be reset

    Examples:
      | TYPE OF ERROR         | PASSWORD |
      | Missing Lower Case    | P@SSW0RD |
      | Missing Upercase Case | p@ssw0rd |
      | Missing Special Char  | Passw0rd |
      | Missing Number        | P@ssword |
      | Less Than 8 char      | P@ssw0r  |