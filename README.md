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
    As a [Role or system actor],  
    I want [feature],  
    So that [benefit or business value]  
    
    Acceptance Criteria:  
     - [Make sure 1] 
     - [Make sure 2]
    
    Scenario 1: [Scenario Title]  
    Given some precondition  
    When some action is performed by the actor  
    Then some testable outcome is achieved

As you can see, the Feature has a title and a description. Although optional, it's a good practice to describe the feature through an Agile User Story and the Acceptance Criteria.
The feature can contain one or more _Scenario_ sections (each with a unique title), describing how a feature should behave in different situations or
with different input parameters.  
_Scenarios_ follow the **Given - When - Then** structure and each _keyword_ has a purpose:

    | Keyword   | Purpose                                                                            |
    | Given     | Use the given step to define the initial state                                     |  
    | When      | Define the action performed by the user/actor that will trigger the reward/benefit |
    | Then      | Define the expected outcome from the action taken by the user in the _When_ step   |












          




























