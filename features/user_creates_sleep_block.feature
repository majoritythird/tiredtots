Feature: User creates a sleep block

  Scenario: starting a new sleep block
    Given it is currently "1/1/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    Then I should not see "To get started"
    When I follow "Alex"
    Then I should see "Sleep journal for Alex"
    When I follow "new sleep block"
    And I fill in "Start" with "2:15PM"
    And I press "save"
    Then I should see "Sleep journal for Alex"
    And I should see "Start: Jan 1 2:15PM"

  Scenario: sleep blocks require start times
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I follow "new sleep block"
    And I fill in "Start" with ""
    And I press "save"
    Then I should see "Start can't be blank"
