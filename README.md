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

Let’s take a look at simple example of a user signing into QAsimodo.

    
    Feature: Login into QAsimodo
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

The scenario should be written in a way that even people who do not know the feature will understand it. If you see the scenario in the example, it's descriptive and concise 
and has been wrote in a way that even a non-technical person can understand how the Login feature should behave under a certain condition. So, write your
scenarios describing feature's behavior in way that is clear to all your team members and you will dispel misunderstandings and ambiguity.

For sure this feature has more Acceptance Criteria and therefore Scenarios to be considered, and we will be working on them as we go forward in this guide.   
Think a second about which other behavior should be done by the Login feature! That's it. Login feature should not allow unregistered users to sign into QAsimodo,
so you must update the Acceptance Criteria and add an Scenario as follow:

    
    Feature: Login into QAsimodo
      As a Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to start a private testing session.
    
      Make sure:
      - Username and password are mandatory to login 
      - Registered users are able to login
      - Unregistered users are not able to login
       
      Scenario: Login successful
        Given I am Mark the Tester  
        And I have a valid account on QAsimodo with the following credentials:  
          | Username | Password |
          | Mark     | Pas      |              
        When I correctly submit my account credentials  
        Then I should be logged in
      
      Scenario: Login unsuccessful - Account does not exist
        Given I am Lauren the Tester
        And I do not have an account on QAsimodo
        When I try to login guessing credentials
        Then I should not be able to login

TBD
