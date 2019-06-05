# Creating QAsimodo Credentials

Let's see how to write a feature file for creating QAsimodo account credentials

Start writing the user story. The user story should identify an actor, the feature the actor wants and the outcome or business value he will get. So, think about who is the actor
interested about having QAsimodo credentials? Which is the reward/benefit the actor will get through the feature? Have a look to our suggestion:  

    User Story:
    As Lauren the Tester
    I want to create a QAsimodo account by entering email address and password
    so that I am able to start using QAsimodo   

The major QAsimodo actors are the Testers and they want to have their own access credentials so that they are able to use the application and have a private testing session.

Start writing the acceptance criteria. Think about the user requirements that, if fulfilled, will make the final product (feature) relevant to the customer's requirements. Remember that the acceptance criteria
should indicate the customer's intent (what) and not the solution (how). It is up to the development team to find the solution.

You can start writing something like:

    Make sure:
      - Email address and password are the account credentials
      - It's possible to access to QAsimodo with new account credentials
      - It's not possible to create new account credentials with an already existing Email address (identity information)  
             

Does it make sense? Sure, you have to ensure that new registered users are able to login into QAsimodo (main feature purpose), and of course that 
users have a unique ID in the system.

Now you are able to start writing your feature behavioral examples (scenarios). How should the feature behave? Think about: Under which conditions the feature will 
successfully create the credentials? Under which conditions the feature won't create the credentials? Can the same user register multiple times?     
A good practice is to start with the happy path, which in this case will be something like:


    Scenario: Successful account creation 
        Given I am Lauren the Tester
        And my Email address is not associated with a QAsimodo account
        When I provide my email address
        And I set a password 
        Then my account credentials should be created
        And I should be able to login with my new credentials
        
After the happy path you should write all the exception (or negative) paths. For now, we can write the example for when an email address is already registered in the system:

    Scenario: Unsuccessful account creation  - Email address already registered
        Given I am Lauren the Tester
        And my Email address is already registered as a QAsimodo account
        When I provide my email address
        And I set a password 
        Then I should not be able to create my account credentials

That's it! No problems, right?

Now let's work with some Non-Functional requirements that should be taken into account within this feature! We'll have a look to some security and usability requirements.  

As in the [_Login Example_](TBD), the security team informs you that the _creating QAsimodo credentials feature_ must take into account the following specifications:
* Users won't be able to set a password until they do not confirm their Email address to avoid some simple bots.
* Password must be [secure](https://www.owasp.org/index.php/Testing_for_Weak_password_policy_(OTG-AUTHN-007)), so it must fulfill the following characteristics: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].  

On the other hand for usability reasons:
* Password should be required twice, before being set, to avoid mistyping.
* User's email should be verify to avoid mistyping.
* Users should be redirected to the sign in page once the account has been created.

How would you write/modify your feature file? How many new scenarios should you write? Before moving forward, remember: _one scenario should cover one behavior._  
First of all, update your acceptance criteria, as follows:

    Feature: Creating QAsimodo Account
      As Lauren the Tester
      I want to create a QAsimodo account by entering email address and password
      so that I am able to start using QAsimodo
    
      Make sure:
      - Email address and password are the account credentials
      - It's possible to access to QAsimodo with new account credentials
      - It's not possible to create new account credentials with an already existing Email address (identity information)
      - Verification Email is sent to the User Email address (User is able to verify the Email address)
      - Password cannot be set until Email address has been verified
      - Password is required twice before it is set to avoid mistyping (Password is set only if both passwords match)
      - Password follows security standards: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
      - User is redirected to QAsimodo sign in page once the account credentials have been created

Now, review the scenarios we presented before. Are they still congruent with the acceptance criteria? They are not! How would you update them? Have a look:


     Feature: Creating QAsimodo Account
     As Lauren the Tester
     I want to create a QAsimodo account by entering email address and password
     so that I am able to start using QAsimodo

     Make sure:
     - Email address and password are the account credentials
     - It's possible to access to QAsimodo with new account credentials
     - It's not possible to create new account credentials with an already existing Email address (identity information)
     - Verification Email is sent to the User Email address (User is able to verify the Email address)
     - Password cannot be set until Email address has been verified
     - Password is required twice before it is set to avoid mistyping (Password is set only if both passwords match)
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
       
Let's analyze the first scenario (happy path). If you notice, we explicitly write the email address "lauren@example.com" since this address will be used 
to validate the email. The actions that will trigger the outcome (When steps) are the successful email validation and password setting. Finally, we added the redirection to the sign in page.

We have created a new scenario in which a user that has already created a new account is able to login into the system, which is the second scenario in the example above.
We have split this behavior from the creation one since is other feature's behaviour (One thing is creating the credentials and the other one is accessing the system
with those ones). On the other hand, if you review the password we have wrote on the scenario, it fulfill the security requirements, so as we did, write your scenarios following the acceptance criteria you establish!           

Once you have updated your scenarios with the new acceptance criteria, you have to create scenarios to cover all the NFR. Let's start with the usability ones: 1) User should be able to
verify their email address and 2) User must repeat new password to avoid mistyping.

    Feature: Creating QAsimodo Account
      As Lauren the Tester
      I want to create a QAsimodo account by entering email address and password
      so that I am able to start using QAsimodo
    
      Make sure:
      - Email address and password are the account credentials
      - It's possible to access to QAsimodo with new account credentials
      - It's not possible to create new account credentials with an already existing Email address (identity information)
      - Verification Email is sent to the User Email address (User is able to verify the Email address)
      - Password cannot be set until Email address has been verified
      - Password is required twice before it is set to avoid mistyping (Password is set only if both passwords match)
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
        And my Email address is not associated with a QAsimodo account
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
        
_For information about how to manage tags in QAsimodo (Ex: @usability) click [here](tbd)._


Finally you have to cover the last acceptance criteria, which is the password validation! We suggest to use the scenario outline [(Read about how to use scenario outline)](tbd), since different kind 
of inputs will generate the same feature behaviour (e.g. password won't be set). Which examples would you write in order to ensure that the password fulfills the security requirements
(more than 7 characters, one lower case and one upper case alpha character: {a-z, A-Z}, one non-alphanumeric character: {!@#$%^&*()} and one numeric character: {0-9} )? 
Which cases would you consider? 

We suggest to write 'mutually exclusive' examples for each requirement, which means you should focus only on the password requirement you are describing. For instance,
if you are describing that the password must have 'one lower case character' case, then write a password example that meets all other requirements.     
Review other examples in the following table:

    | EXAMPLE              | PASSWORD |
    | Missing Lowercase    | P@SSW0RD |
    | Missing Uppercase    | p@ssw0rd |
    | Missing Special Char | Passw0rd |
    | Missing Number       | P@ssword |
    | Less Than 8 char     | P@ssw0r  |

All password examples above meet all the security requirements except the one that you are describing. With the examples above, you are now able to write
the scenario outline that describes the behavior:

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
      - Password is required twice before it is set to avoid mistyping (Password is set only if both passwords match)
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
        # Usability because deals with mistyping. Security because prevents some simple bots
      Scenario: User should be able to verify the email address
        Given I am Lauren the Tester
        And my Email address is "lauren@example.com"
        And my Email address is not associated with a QAsimodo account
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

