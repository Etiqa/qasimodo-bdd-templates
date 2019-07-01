# How to write good scenarios

Do you feel blocked to start writing your BDD scenarios? In this section we will give you some good practices that will help you to write good scenarios.

Keep always in mind to write your scenarios so that people who do not know the feature will understand it! So, treat your readers as you'd like to be treated.

#### 1) Behaviour over Procedure

Usually as you get started writing feature files you might be tempted to write them with a _procedure-driven_ mindset, which is just step-by-step instructions
with actions and expected results. 
Let's say you are asked to write a scenario describing the Login to QAsimodo procedure. Usually before writing the scenario you first think on the whole process as follows:
1. Open a web browser -> Once the browser opens successfully you go to 2.
2. Go to QAsimodo login page -> Once the page is loaded you go to 3
3. Enter Username and Password 
4. You are logged into the application

And after that you write the scenario as the following example:

    BAD EXAMPLE! This Feature is just to show how procedure-driven scenarios are written! Avoid writing scenarios like this!
    
    Feature: Login into QAsimodo
      As Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to use the Application
    
      Make sure:
      - Username and password are mandatory to login
      - Registered users are able to login
    
      Scenario: Successful Login - (Procedural Example)
        Given I am Mark the Tester
        And I have a valid account on QAsimodo with the following credentials:
          | Username | Password |
          | Mark     | Pass     |
        When I open a web browser
        And I navigate to "https://{mydomain}.qasimodo.io"
        Then I should land on Qasimodo Sign In page
        When I enter "Mark" into the Username text field
        And I enter "Pass" into the Password text field
        And I click on "Login" button
        Then I should be logged in
  
Avoid writing Scenarios like the above one, in which each step is like a traditional test. Behavior-driven is not just putting BDD buzzwords in front of each step
but instead the idea is describing how your feature should behave under some conditions, through examples. Do you think the previous scenario is concise and clear to easily 
understand the feature behavior? 

Procedure-driven scenarios lead to write extremely long scenarios and generate confusion within the team. Moreover, by writing
procedural scenarios, you are tracing a path covering multiple system behaviours.    

An advice is **writing declarative steps** instead of imperative steps. For example, the steps: "When I open a web browser and I navigate to "https://{mydomain}.qasimodo.io"" "
are purely imperative! You should write something like: "Given a web browser is at QAsimodo sign in page", which is a more declarative step and also is 
friendly to read.

On the other hand, **any single When-Then pair denotes an individual behavior**. Review the scenario above again! Is the writer covering just one behavior?
Actually there are two features covered: 
1. Direct navigation to QAsimodo sign in page
2. Login into QAsimodo

The advice here is to split your scenarios in a way that **one scenario covers one behavior**, so any time you write more than one When-Then pair, try to
write separate scenarios. (This is not a rule! Some scenarios cannot be split but be aware about duplicating behaviors). 

Be careful as well of writing behaviors that are not part of your feature. For instance, the direct navigation to QAsimodo is a behavior of another feature
and has nothing to do with the Login. 

The correct Login feature file should look as follows (Recall our simple login example):

    Simple Example: Successful Login
    
    Feature: Login into QAsimodo - Simple Example
      As Mark the Tester
      I want to be able to login in QAsimodo
      So that I am able to use the Application
    
      Make sure:
      - Username and password are mandatory to login
      - Registered users are able to login
    
      Scenario: Successful Login - (Simple Example)
        Given I am Mark the Tester
        And I have a valid account on QAsimodo with the following credentials:
          | Username | Password |
          | Mark     | Pass     |
        When I correctly submit my account credentials
        Then I should be logged in
            
Is it better right? Do you see big differences?

#### 2) Do not describe the implementation

When writing your examples focus on the "**What**", not on the "How". This is very important because in this way you give your team the freedom 
to determine the best implementation of the feature. 

For example, users "submit authentication credentials", they do not "click the submit button". Review the _Bad Example_ shown before and find others steps
that describe the "how" and not the "what".

Avoid to describe the user interaction with the UI and to specify the implementation. Doing so, you won’t limit your team neither your feature/application implementation

If you are describing the implementation or writing technical details, stop a second and ask yourself: "What for?" or "Why?" is the feature needed/wanted. This will help you to have
a broader perspective, making easier to describe the feature's behavior.

#### 3) Use appropriate tense for each type of step

Keep in mind the purpose of each keyword when writing steps.   
    
    |Keyword    | Purpose                                                                            |
    | Given     | Use the given step to define the initial state                                     |  
    | When      | Define the action performed by the user/actor that will trigger the reward/benefit |
    | Then      | Define the expected outcome from the action taken by the user in the _When_ step   |    

Avoid writing actions in the Given steps. They are meant to define an initial state, not to exercise a behavior. You should write Given steps in present or present perfect tense.

When steps are meant to indicate that an action is happening presently, write When steps using action present tense. (avoid past tense)

Then steps should not be written as a future tense since this leads to be more procedural (imperative) over behavioral (declarative). Write your Then steps in present and using some conditionals when required.  


Feel free to explore our [**_BDD Templates Library_**](https://github.com/Etiqa/qasimodo-bdd-templates/tree/master/features)! There, you will find
many useful examples of feature files that will help you write your owns. 
























