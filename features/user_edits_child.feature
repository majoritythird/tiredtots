Feature: User edits child

  Scenario: changing the name
    Given I am signed in
    And I have the following children:
      | name | Alex |
    When I am on the home page
    And I follow "(manage)"
    Then I should see "Your Children"
    When I follow "edit"
    Then I should see "Edit Child"
    When I fill in "Name" with "Alexander"
    And I press "save"
    Then I should see "Your Children"
    And I should see "Alexander"

  Scenario: canceling an edit
    Given I am signed in
    And I have the following children:
      | name | Alex |
    When I am on the home page
    And I follow "(manage)"
    And I follow "edit"
    When I follow "cancel"
    Then I should see "Your Children"
    And I should see "Alex"
