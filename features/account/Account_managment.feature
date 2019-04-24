Feature: Update Personal Information
  As a logged-in user
  I should be able to update my profile data
  So that I keep profile information up-to-date

  Scenario Outline: Update personal information
    Given I am a logged user
    And I am on my profile page
    When I update my current "<INFO>"
    And I save my changes
    Then my personal information should be updated
    And I should see a confirmation message like:
    """
    Profile updated successfully.
    """

    Examples:
      | INFO       |
      | Given Name |
      | Last Name  |

  Scenario Outline: User should not be able to remove personal information
    Given I am a logged user
    And I am on my profile page
    When I delete my current "<INFO>"
    And I save my changes
    Then I should not be able to update my personal information
    And I should see an error message like:
    """
    <INFO> is mandatory
    """

    Examples:
      | INFO       |
      | Given Name |
      | Last Name  |
    

