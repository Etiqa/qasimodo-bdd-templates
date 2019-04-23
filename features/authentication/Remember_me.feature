Feature: Remembering Credentials
  As a User
  I want the system be able to remember my login credentials
  So that I am able to login in a fast way

  Scenario: Remember login credentials
    Given I am a user
    And I am on sign in page
    When I enable "Remember" service
    And I successfully login
    Then next time I try to login my authentication information should be automatically filled

  Scenario: Disabling Remember service
    Given I am a user
    And I am on sign in page
    When I disable "Remember" service
    And I successfully login
    Then next time I try to login my authentication information should not be automatically filled

  Scenario: Login with remembered credentials
    Given I am a user
    And I am on sign in page
    And my credentials have been remembered from last login
    When I login with the remembered credentials
    Then I should be logged in