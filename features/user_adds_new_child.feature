Feature: User adds new child

  Scenario: adding the first child
    Given an existing user
    When I go to the home page
    Then I should see "To get started, add a child"
    When I follow "add a child"
    Then I should see "New Child"
    When I fill in "Name" with "Alex"
    And I press "add"
    Then I should see "Children"
    And I should see "Alex"

  Scenario: without entering a name
    Given an existing user
    And I am on the home page
    When I follow "add a child"
    And fill in "Name" with ""
    And I press "add"
    Then I should see "Name can't be blank"
