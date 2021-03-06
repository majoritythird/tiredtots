Feature: User adds new child

  Scenario: adding the first child
    Given I am signed in
    When I go to the home page
    Then I should see "To get started, add a child"
    When I follow "add a child"
    Then I should see "New Child"
    When I fill in "Name" with "Alex"
    And I press "save"
    Then I should see "Children"
    And I should see "Alex"
    When I follow "Alex"
    Then I should be on the sleep journal page for Alex

  Scenario: without entering a name
    Given I am signed in
    And I am on the home page
    When I follow "add a child"
    And fill in "Name" with ""
    And I press "save"
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

  Scenario: with a duplicate child name
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "(manage)"
    And I follow "Add a child"
    And I fill in "Name" with "Alex"
    And I press "save"
    Then I should see "Name has already been taken"
    When I fill in "Name" with "alex"
    And I press "save"
    Then I should see "Name has already been taken"

  Scenario: with url-unfriendly characters in the name
    Given I am signed in
    When I go to the home page
    And I follow "add a child"
    And I fill in "Name" with "Alex the Great/&?\est"
    And I press "save"
    Then I should see "Alex the Great/&?\est"
    When I follow "Alex the Great/&?\est"
    Then I should be on the sleep journal page for Alex the Great/&?\est

  Scenario: canceling the creation of the first child
    Given I am signed in
    When I go to the home page
    And I follow "add a child"
    And I follow "cancel"
    Then I should see "To get started, add a child"

  Scenario: canceling the creation of the second child
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "(manage)"
    And I follow "Add a child"
    And I follow "cancel"
    Then I should see "Your Children"
    And I should see "Alex"

  Scenario: with a name already in use by another user
    Given an existing user
    And that user has the following child:
      | name | Alex |
    And I am signed in
    When I go to the home page
    And I follow "add a child"
    And I fill in "Name" with "Alex"
    And I press "save"
    Then I should see "Your Children"
    And I should not see "Name has already been taken"
    And I should see "Alex"
