Feature: User adds new child

  Scenario: adding the first child
    Given I am signed in
    When I go to the home page
    Then I should see "To get started, add a child"
    When I follow "add a child"
    Then I should see "New Child"
    When I fill in "Name" with "Alex"
    And I press "add"
    Then I should see "Children"
    And I should see "Alex"

  Scenario: without entering a name
    Given I am signed in
    And I am on the home page
    When I follow "add a child"
    And fill in "Name" with ""
    And I press "add"
    Then I should see "Name can't be blank"

  Scenario: without signing in first
    Given the following user:
      | email    | user@example.com |
    And I am signed out
    When I go to the add new child page
    Then I should not see "New Child"
    And I should see "You need to sign in or sign up before continuing"
    When I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "New Child"
