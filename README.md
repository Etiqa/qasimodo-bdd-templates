# QAsimodo BDD Templates

BDD (Behavioral Driven Development) or Specification by Examples is a methodology for developing software through continuous example-based 
communication between developers, QAs and BAs. The primary purpose of BDD methodology is to improve communication amongst the stakeholders 
of the project so that each feature is correctly understood by all members of the team before the development process starts. 
This helps to identify key scenarios for each story and also to eradicate ambiguities from requirements.

## Feature File Structure
In BDD, examples are called Scenarios. Scenarios are written in a special format called [Gherkin](https://automationpanda.com/2017/01/26/bdd-101-the-gherkin-language/). 
Scenarios explain how a given feature should behave in different situations with different input parameters.  
Scenarios should be stored in a Feature file (text files with a ".feature" extension). The purpose of the Feature file is to provide a high-level 
description of a software feature, and to group related scenarios.
      
These feature files tend to follow a specific format that is fairly straight forward, 
and with a little practice you'll be able to write your own. Have a look:

    Feature: [Feature Title]

    User Story:  
    *As a [Role or system actor],  
    I want [feature],  
    So that [benefit or business value]*  
    
    Acceptance Criteria:  
     - [Make sure 1] 
     - [Make sure 2]
    
    _Scenario 1_: [Scenario Title]  
    _Given_ some precondition  
    _When_ some action is performed by the actor  
    _Then_ some testable outcome is achieved

As you can see, the Feature has a title and a description. It's a good practice to describe the feature through an Agile user story and the Acceptance Criteria.
The feature can contain one or more _Scenario_ sections (each with a unique title), describing how a feature should behave in different situations or
with different input parameters.  
_Scenarios_ follow the **Given - When - Then** structure and each _keyword_ has a purpose:

    |**Keyword**| **Purpose**                                                                       |
    | Given     | Use the given step to define the inital state                                     |  
    | When      | Define the action performed by the user/actor that will trigger the reward/benefit|
    | Then      | Define the expected outcome from the action taken by the user in the _When_ step  |

## BDD Functional Requirements
Let’s take a look at simple example of a user signing into QAsimodo.

    Feature: Login into QAsimodo - Simple Example
      As a Mark the Tester
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
    
This a complete feature file following the format introduced before. It starts with a required Feature (that is login to QAsimodo) and its description (the user story),
telling us who is the target user or (role), the feature user wants and the reward the user will get. The acceptance criteria are an intrinsic part of the story
and define the scope of its behavior, giving a share definition, within the team, of when the story can be considered as "done".  

The scenario should be written in a way that even people who do not know the feature will understand it. If you see the scenario in the example above, it's descriptive and concise 
and has been wrote in a way that even a non-technical person can understand how the Login feature should behave under a certain condition. So, write your
scenarios describing feature's behavior in way that is clear to all your team members and you will dispel misunderstandings and ambiguity.

For sure this feature has more Acceptance Criteria and therefore Scenarios to be considered, and we will be working on them as we go forward in this guide.   
Think a second about which other behavior should be done by the Login feature! That's it. Login feature should not allow unregistered users to sign into QAsimodo,
so you must update the Acceptance Criteria and add an Scenario as follow:

    
    Behavioral Approach of Login feature. Just Functional Requirements
    
    Feature: Login into QAsimodo - Behavioral
      As a Mark the Tester
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
the login feature should be complete now since the functional requirements has been covered.

## BDD for Non-functional Requirements
Non-functional requirements (NFR), known as 'quality attributes', specifies criteria that can be used to evaluate the system operation instead of a 
specific behavior. NFRs define how a system is supposed to be, rather than what a system is supposed to do. Some NFRs examples are:  
* Security
* Usability
* Accessibility
* Performance
* Stability
* [Review others](https://www.altexsoft.com/blog/business/functional-and-non-functional-requirements-specification-and-types/)
     
You are able to describe non-functional requirements through BDD. NFRs should be considered as design constraints within your team.  

Let's move forward with our login example and integrate some NFRs!
Suppose the security department aware you that the _login feature_ must follow the [OWASP](https://www.owasp.org/index.php/Main_Page) (Open Web Application Security Project) standards.
For instance, security department states that, when a user try to login submitting wrong credentials, the system should not reveal if a username exists
or if the provided password is wrong. This information can used by an attacker to obtain a list of user on system. In summary your login feature should response with the same error message
for every failed attempt of authentication. [More info](https://www.owasp.org/index.php/Testing_for_Account_Enumeration_and_Guessable_User_Account_(OTG-IDENT-004)) 

How would you add this design constraint (NFR) into the login feature file? Which scenarios would you consider?

The cases you should consider are (both of them should trigger the same error message): 
1. The user login with wrong username
2. The user login with wrong password  

The above will be the scenarios you should add to your feature file! Don't forget to insert the NFR to the Acceptance Criteria! Have a look:

    Example: Adding Non Functional Requirements
    
    Feature: Login into QAsimodo
      As a Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to use the Application
    
      Make sure:
      - Username and password are mandatory to login
      - Registered users are able to login
      - Unregistered users are not able to login
      - Authentication with wrong credentials follow OWASP standards: 
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
        Your credentials are wrong!
        """
    
        Examples:
          | CREDENTIAL |
          | Username   |
          | Password   |  

_For information about how to use Scenario Outline click [here](tbd)_
_For information about how to manage tags (Ex: @security) click [here](tbd)_

Has been the scenario written as you thought? Do you think a non-technical person will understand (through the examples) how the Login feature should behave under the NFR?
Absolutely yes! The scope is to make others understand that when logging in with wrong username or password, the same outcome (error message) should 
be displayed by the system for security reasons. Moreover, see how _declarative_ the scenario is even describing NFR. [(How to write good scenarios)](TBD)

You can detail, deeper and deeper, you feature file (through your scenarios) as you need! It's up to you and the requirements that your feature or
system needs, in order to achieve the customer reward/satisfaction. Feel free to explore our [**_BDD Templates Library_**](tbd)! There you will find
many useful example feature files that will help you write your owns.








          




























