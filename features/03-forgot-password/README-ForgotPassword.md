# Reset Password Feature

Now it's your turn to practice! Do you feel capable of writing a feature file describing the behavior of a 'Reset Password Feature'? Feel free to review 
the examples we have introduced, anytime. If you feel blocked try to follow this steps:
1) Define the User Story
2) Define the Acceptance Criteria for your feature covering both the Functional and Non-Functional requirements
3) Write the first scenario covering the happy path
4) Write the exception paths 
4) Write scenarios in order to cover all your acceptance criteria

Hint: Take the same non-functional requirements (as security and usability ones) that we have used in the [Creating QAsimodo Account Example](tbd) 

Have a look: 
 
    Feature: Forgot password
      As Lauren the Tester
      I want to be able to reset my password
      So that I can access to QAsimodo even if I forgot my current password
    
      Make sure:
        - It's possible to request to reset the password
        - It's possible to access to QAsimodo with new password account
        - After reset, it's not possible to access to QAsimodo with the old password
        - Password cannot be reset until user identity has been verified (e.g. through Email address)
        - Users are able to verify their identity
        - Password is required twice before it is reset to avoid mistyping (Password is reset only if both passwords match)
        - Password follows security standards: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
        - User is redirected to QAsimodo sign in page once the password is reset

        Scenario: Successful password reset
          Given I am Lauren the Tester
          And I have a QAsimodo account with the following email: "lauren@example.com"
          But I have forgot my password
          When I request to reset my password
          And I validate my Email address
          And I correctly set a new password that follows the security standard
          Then my new password should be set
          And I should be redirected to QAsimodo sign in page

        Scenario: Once the password has been reset, Users should be able to access to QAsimodo with the new password
          Given I am Lauren the Tester
          And I have a QAsimodo account with the following credentials:
            | Email              | Password |
            | lauren@example.com | P@ssw0rd |
          When I successfully reset my password to:
            | New Password |
            | NewP@ssw0rd  |
          Then I should be able to login into QAsimodo with "NewP@ssw0rd" password

        Scenario: Users should not be able to access to QAsimodo with old password
          Given I am Lauren the Tester
          And I have a QAsimodo account with the following credentials
            | Email              | Password |
            | lauren@example.com | P@ssw0rd |
          When I reset my password to:
            | New Password |
            | NewP@ssw0rd  |
          Then I should not be able to login into QAsimodo with "P@ssw0rd" password


        @usability @security
          # Usability because it deals with mistyping. Security because prevents some simple bots
        Scenario: User should be able to verify the email address
          Given I am Lauren the Tester
          And my Email address is "lauren@example.com"
          When I request to reset my password
          And  submit my Email address
          Then I should be able to verify my Email address
          And I should be able to reset my password

        @usability
        Scenario: User must repeat new password to avoid mistyping
          Given I am Lauren the Tester
          And I have validated my Email address
          But I have not yet reset my password
          When I submit the following information
            | New Password | Confirm New Password |
            | P@ssw0rd     | P@ssw0rd!            |
          Then I should not be able to reset my password
          And I should get an error message as:
          """
          Passwords must match!
          """

        @security
        Scenario Outline: The new password must be secure: <TYPE OF ERROR>
          Given I am Lauren the Tester
          And I have verified my Email address
          But I have not yet reset my password
          When I submit a "<TYPE OF ERROR>" password as:
            | New Password | Confirm New Password |
            | <PASSWORD>   | <PASSWORD>           |
          Then I should not be able to reset my password
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