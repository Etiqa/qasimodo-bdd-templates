# Login into QAsimodo Feature

### BDD for Functional Requirements
Let’s take a look at simple example of a user signing into QAsimodo.

    Feature: Login into QAsimodo - Simple Example
      As Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to start a private testing session.
    
      Make sure:
      - Username and password are mandatory to login
      - Registered users are able to login
       
      Scenario: Login successful
        Given I am Mark the Tester  
        And I have a valid account on QAsimodo with the following credentials:  
          | Username | Password |
          | Mark     | Pass     |              
        When I correctly submit my account credentials  
        Then I should be logged in
    
This a complete feature file following the format introduced [before](https://github.com/Etiqa/qasimodo-bdd-templates/blob/master/README.md). It starts with a required Feature (that is Login into QAsimodo) and its description (the user story),
telling us who is the target user (or role), the feature user would like to have and the reward the user will get. The acceptance criteria are an intrinsic part of the story
and define the scope of its behavior, giving a shared definition, within the team, of when the story can be considered as "done".  

The scenario should be written so that even those who do not know the feature will understand it. If you see the scenario in the example above, it's descriptive and concise 
and has been written in a way that even a non-technical person can understand how the Login feature should behave under a certain condition. So, write your
scenarios describing the feature's behavior in a way that is clear to all your team members and you will dispel misunderstandings and ambiguity.

For sure this feature has more Acceptance Criteria and therefore Scenarios to be considered, and we will be working on them as we go forward in this guide.   
Think a second about which other behavior should be considered for the Login feature! That's it. Login feature should not allow unregistered users to sign into QAsimodo,
so you must update the Acceptance Criteria and add a Scenario as follows:

    
    Behavioral Approach of Login feature. Only Functional Requirements
    
    Feature: Login into QAsimodo - Behavioral
      As Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to use the Application
    
      Make sure:
      - Username and password are mandatory to login
      - Registered users are able to login
      - Unregistered users are not able to login
    
      Scenario: Login successful
        Given I am Mark the Tester
        And I have a valid account on QAsimodo with the following credentials:
          | Username | Password |
          | Mark     | Pass     |
        When I correctly submit my account credentials
        Then I should be logged in
    
      Scenario: Login unsuccessful - Account does not exist
        Given I am Lauren the Tester
        And I do not have an account on QAsimodo
        When I try to login guessing credentials
        Then I should not be able to login

Simple right? From a Behavioral point of view, a _login feature_ should allow or not allow access (under some conditions) to the application. So 
the login feature should be complete now since the functional requirements have been covered.

## BDD for Non-functional Requirements
Non-functional requirements (NFR), known as 'quality attributes', specify criteria that can be used to evaluate the system operation instead of a 
specific behavior. NFRs define how a system is supposed to be, rather than what a system is supposed to do. Some NFRs examples are:  
* Security
* Usability
* Accessibility
* Performance
* Stability
* [Review others](https://www.altexsoft.com/blog/business/functional-and-non-functional-requirements-specification-and-types/)
     
You are able to describe non-functional requirements through BDD. NFRs should be considered as design constraints within your team.  

Let's move forward with our login example and integrate some NFRs!
Suppose the security department informs you that the _login feature_ must follow the [OWASP](https://www.owasp.org/index.php/Main_Page) standards (Open Web Application Security Project).
For instance, security department states that, the system should not reveal if a username exists, or if the provided password is wrong, when a user tries to login submitting wrong credentials.
This information can be used by an attacker to obtain a list of users on system. In summary, your login feature should return the same error message
for every failed attempt of authentication. [More info](https://www.owasp.org/index.php/Testing_for_Account_Enumeration_and_Guessable_User_Account_(OTG-IDENT-004)) 

How would you add this design constraint (NFR) into the login feature file? Which scenarios would you consider?

The cases you should consider are (both of them should trigger the same error message): 
1. User login with wrong username
2. User login with wrong password  

The above will be the scenarios you should add to your feature file! Don't forget to insert the NFR to the Acceptance Criteria! Have a look:

    Example: Adding Non Functional Requirements
    
    Feature: Login into QAsimodo
      As Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to use the Application
    
      Make sure:
      - Username and password are mandatory to login
      - Registered users are able to login
      - Unregistered users are not able to login
      - Authentication with wrong credentials follows OWASP standards: 
            * System should answer in the same way for every failed attempt of authentication (Examples: wrong username, wrong password)
    
      Scenario: Login successful
        Given I am Mark the Tester
        And I have a valid account on QAsimodo with the following credentials:
          | Username | Password |
          | Mark     | Pass     |
        When I correctly submit my account credentials
        Then I should be logged in
    
      Scenario: Login unsuccessful - Account does not exist
        Given I am Lauren the Tester
        And I do not have an account on QAsimodo
        When I try to login guessing credentials
        Then I should not be able to login
    
      @security
      Scenario Outline: System should answer with a generic error message when Logging in with wrong "<CREDENTIAL>"
        Given I am Mark the Tester
        And I have a valid account on QAsimodo with the following credentials:
          | Username | Password |
          | Mark     | Pass     |
        When I login submitting wrong "<CREDENTIAL>"
        Then I should not be able to login
        And I should see an authentication error message as:
        """
        Username and/or Password are wrong!
        """
    
        Examples:
          | CREDENTIAL |
          | Username   |
          | Password   |  

_For information about how to use Scenario Outline click [here](tbd)._
   
_For information about how to manage tags in QAsimodo (Ex: @security) click [here](tbd)_.

Was the scenario written as you thought? Do you think a non-technical person will understand (through the examples) how the Login feature should behave under the NFR? 
Absolutely yes! The scope is to make others understand that when logging in with wrong username or password, the same outcome (error message) should 
be displayed by the system for security reasons. Moreover, see how _declarative_ the scenario is even describing NFR. [(How to write good scenarios)](https://github.com/Etiqa/qasimodo-bdd-templates/blob/master/Guide-writing-scenarios.md)

You can detail your feature file through scenarios, deeper and deeper, as you need! It's up to you and the requirements that your feature or
system needs, in order to achieve the customer reward/satisfaction. Feel free to explore our [**_BDD Templates Library_**](https://github.com/Etiqa/qasimodo-bdd-templates/tree/master/features)! There, you will find
many useful examples of feature files that will help you write your owns.










          




























