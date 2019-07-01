Feature: Remember login credentials
  As the system
  I should be able to save any user’s QAsimodo login credentials
  So that users are able to access the Application in a fast way

  Make sure:
  - Users are able to enable the 'remember me' service
  - Users are able to disable the 'remember me' service
  - Authentication credentials are remembered once the user has successfully logged in
  - Users are able to login with remembered credentials

  Scenario: Remembering authentication credentials
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | Pass     |
    When I login with 'remember me' service enabled
    Then the system should save my authentication credentials

  Scenario: User should be able to login into QAsimodo with 'Remembered' credentials
    Given I am Mark the Tester
    And the system has saved my authentication credentials
    When I login with the remembered credentials
    Then I should be logged in

  Scenario: Authentication credentials should not be saved when remember service is disabled
    Given I am Mark the Tester
    And I have a valid account on QAsimodo with the following credentials:
      | Username | Password |
      | Mark     | Pass     |
    When I login with 'remember me' service disabled
    Then the system should not save my authentication credentials

