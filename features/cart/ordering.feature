Feature: Ordering items
  As a User
  I want to be able to place orders
  So that I can get the items I want

  Scenario: Ordering successful
    Given I am a user
    And I have added items into my cart
    When I correctly submit "Shipping Information"
    And I correctly submit "Billing Information"
    Then my order should be placed
    And I should see a success message like:
    """
    Your order has been placed. You will get your items in the next 3-5 days
    """

  Scenario Outline: Ordering unsuccessful - Wrong "<INFORMATION>" information
    Given I am a user
    And I have added items into my cart
    When I submit invalid "<INFORMATION>" Information
    Then my order should not be placed
    And I should see an error message

    Examples:
      | INFORMATION |
      | Shipping    |
      | Billing     |

  Scenario: Ordering unsuccessful - Empty Cart
    Given I am a user
    And I have no items in my cart
    Then I should not be able to place an order
    And I should not be able to submit "Shipping Information"
    And I should not be able to submit "Billing Information"
