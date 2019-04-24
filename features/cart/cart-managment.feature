Feature: Managing items in the cart
  As a User
  I want to be able to manage my cart
  So that I am able to order the quantity items I want

  Scenario Outline: Adding items to the cart
    Given I am a user
    And I have "<INITIAL>" items in my cart
    When I add "<QUANTITY>" items
    Then my cart should have "<FINAL>" items

    Examples:
      | INITIAL | QUANTITY | FINAL |
      | 0       | 2        | 2     |
      | 2       | 3        | 5     |

  Scenario Outline: Removing items to the cart
    Given I am a user
    And I have "<INITIAL>" items in my cart
    When I remove "<QUANTITY>" items
    Then my cart should have "<FINAL>" items

    Examples:
      | INITIAL | QUANTITY | FINAL |
      | 3       | 2        | 1     |
      | 1       | 1        | 0     |

  Scenario: User can order up to 10 items
    Given I am a user
    And I have 10 items in my cart
    When I try to add a new item
    Then I am not able to do it
    And I see a message like:
    """
    You can just order up to 10 items.
    """
    And my cart should have 10 items

  Scenario: User should not be able to remove items when cart is empty
    Given I am a user
    And my cart is empty
    Then I should not be able to remove items
    And I see a message like:
    """
    Your cart is empty
    """





