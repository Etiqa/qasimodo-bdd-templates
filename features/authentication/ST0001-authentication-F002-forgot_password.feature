Feature: Forgot password
  As a User
  I want to be able to reset my password
  So that I can use the Application even if I have forgot my current password

  Scenario Outline: Request reset password - via <CHANNEL>
    Given I am a User
    And I have valid account in the system
    But I have forgot my password
    And I am on "forgot password" page
    When I submit the my <CHANNEL>
    Then I should be logged in

    Examples:
    |CHANNEL|
    |Email  |
    |Sms    |



    eset password successful - via email


  Scenario: Login unsuccessful - Wrong Credentials
    Given I am a User
    And I have valid account in the system
    When the user authenticates with wrong credentials
    Then I should not be able to login
    And I should see an error message

  Scenario: Login unsuccessful - Account does not exist
    Given I am a Hacker
    And I have not valid account in the system
    When I try to login guessing credentials
    Then I should not be able to login
    And I should see an error message

  Scenario: Login unsuccessful - Missing Credentials
    Given I am a User
    When I try to login without providing all my authentication information
    Then I should not be able to login