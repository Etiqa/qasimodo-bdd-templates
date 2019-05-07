# Creating QAsimodo Credentials

Let's see how to write a feature file for creating  QAsimodo account credentials

Start writing the user story. The user story should identify an actor, the feature the actor wants and the outcome or business value he will get. So, think about who is the actor
interested about having QAsimodo credentials? Which is the reward/benefit the actor will get through the feature? Have a look to our suggestion:  

    User Story:
    As Lauren the Tester
    I want to create a QAsimodo account by entering email address and password
    so that I am able to start using QAsimodo   

The major QAsimodo actors are the Testers and they want to be able to have their own access credentials so that they are able to use the application and have a private testing session.

Now, start to write the acceptance criteria. Think about which are the user requirements that, if are fulfilled, the end product (feature) will be as expected by the customer? Remember that the acceptance criteria
should state the intent of the client and not the solution (how). It is up to the team to find the solution.

You can start writing something like:

    Make sure:
      - Email address and password are the account credentials
      - It's possible to access to QAsimodo with new account credentials
      - It's not possible to create new account credentials with an already existing Email address (identity information)  
             

Does that make sense? Sure, you have to ensure that new registered users are able to login into QAsimodo (main feature purpose), and of course that 
users have a unique ID in the system.

Now you are able to start writing your feature behavioral examples (scenarios). How the feature should behave? Think about: Under which conditions the feature will 
successfully create the credentials? Under which conditions the feature won't create the credentials? Can the same user register multiple times?     
A good practice is start with the happy path, which in this case will be something like:


    Scenario: Creating account credentials successful
        Given I am Lauren the Tester
        And my Email address is not associated with a QAsimodo account
        When I provide my email address
        And I set a password 
        Then my account credentials should be created
        And I should be able to login with my new credentials
        
After the happy path you should write all exception (negative) paths. For now, we can write the example for when an email address is already registered on the system:

    Scenario: Creating account credentials unsuccessful - Email address already registered
        Given I am Lauren the Tester
        And my Email address is already registered with a QAsimodo account
        When I provide my email address
        And I set a password 
        Then I should not be able to create my account credentials

That's it! No problems, right?

Now let's work with some Non-Functional requirements that should be taken into account within this feature! We'll have a look to some security and usability ones.  

As in the [_Login Example_](TBD), the security team aware you that the _creating QAsimodo credentials feature_ must have into account the following specifications:
* Users won't be able to set a password until they do not confirm their Email address to avoid some simple bots.
* Password must be [secure](https://www.owasp.org/index.php/Testing_for_Weak_password_policy_(OTG-AUTHN-007)), so it must fulfill the following characteristics: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].  

On the other hand for usability reasons:
* Password should be required twice, before is set, to avoid mistyping.
* Email's user should be verify to avoid mistyping.
* Users should be redirected to the sign in page once the account has been created

How would you write/modify your feature file? How many new scenarios should you write? Before moving forward, remember: _one scenario should cover one behavior_
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
      - Password cannot be set until Email address has been verify
      - Password is required twice before is set to avoid mistyping (Password is set only if both passwords match)
      - Password follow security standards: more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].
      - User is redirected to QAsimodo sign in page once the account credentials has been created

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
     - Password cannot be set until Email address has been verify
     - Password is required twice before is set to avoid mistyping (Password is set only if both passwords match)
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
      - Password cannot be set until Email address has been verify
      - Password is required twice before is set to avoid mistyping (Password is set only if both passwords match)
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
        
_For information about how to manage tags in QAsimodo (Ex: @usability) click [here](tbd)_


Finally you have to cover the last acceptance criteria, which is the password validation! We suggest to use the scenario outline [(Read about how to use scenario outline)](tbd), since different kind 
of inputs will generate the same feature behaviour (ex: password won't be set). Which examples you would write in order to ensure the password fulfill the security requirements
(more than 7 characters, one lower case and one upper case alpha character [a-z, A-Z], one numeric character [0-9], and one non-alphanumeric character [example: !@#$%^&*()].)? 
Which cases would you consider? 

We suggest to write 'mutually exclusive' examples for each requirement, which means you should focus only the password requirement you are describing. For instance,
if you are describing the password must have 'one lower case character' case, then write a password example that meets all other requirements, as 'P@SSW0RD'(this password is longer than 7 chars, has an upper case char, one numeric char and one special char. Only misses the lower case char).     
Review other examples in the following table:

    | EXAMPLE                  | PASSWORD |
    | Missing a Lower Case     | P@SSW0RD |
    | Missing an Upercase Case | p@ssw0rd |
    | Missing a Special Char   | Passw0rd |
    | Missing a Number         | P@ssword |
    | Less Than 8 char         | P@ssw0r  |

All password examples above meet with all security requirements except the one that you are describing. Now with the examples before, you are able to write
the scenario outline describing the behavior:

    Feature: Creating QAsimodo Account
      As Lauren the Tester
      I want to create a QAsimodo account by entering email address and password
      so that I am able to start using QAsimodo

      Make sure:
      - Email address and password are the account credentials
      - It's possible to access to QAsimodo with new account credentials
      - It's not possible to create new account credentials with an already existing Email address (identity information)
      - User is able to verify the Email address
      - Password cannot be set until Email address has been verify
      - Password is required twice before is set to avoid mistyping (Password is set only if both passwords match)
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
          | TYPE OF ERROR            | PASSWORD |
          | Missing a Lower Case     | P@SSW0RD |
          | Missing an Upercase Case | p@ssw0rd |
          | Missing a Special Char   | Passw0rd |
          | Missing a Number         | P@ssword |
          | Less Than 8 char         | P@ssw0r  |

