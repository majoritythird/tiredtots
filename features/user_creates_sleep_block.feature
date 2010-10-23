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
    When I fill in "Start time" with "2:15PM"
    And I press "save"
    Then I should see "Sleep journal for Alex"
    And I should see "Jan 1 2:15pm - (unfinished)"

  Scenario: with chronic-friendly strings for the time
    Given it is currently "1/2/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with "yesterday at 4pm"
    And I press "save"
    Then I should see "Jan 1 4:00pm - (unfinished)"

  Scenario: finishing a sleep block
    Given it is currently "1/1/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 1/1/2010 2:15pm |
      | finish_time |                 |
    When I go to the home page
    And I follow "Alex"
    Then I should see "Open sleep block"
    And I should see "Jan 1 2:15pm" in the "Start time" field
    And I fill in "Finish time" with "3:30pm"
    And I press "save"
    Then I should see "Sleep journal for Alex"
    And I should see "Jan 1 2:15pm - Jan 1 3:30pm"

  Scenario: sleep blocks require start times
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with ""
    And I press "save"
    Then I should see "Start time can't be blank"
    And I should not see "Start time is invalid"
    When I follow "cancel"
    Then I should see "Sleep journal for Alex"

  Scenario: sleep blocks with times that cannot be parsed
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with "monkey butter"
    And I fill in "Finish time" with "maybe doughnuts?"
    And I press "save"
    Then I should see "Start time is invalid"
    And I should not see "Start time can't be blank"
    And I should see "Finish time is invalid"

  Scenario: canceling the edit of a sleep block
    Given I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 1/1/2010 2:15pm |
      | finish_time |                 |
    When I go to the home page
    And I follow "Alex"
    And I follow "edit"
    And I follow "cancel"
    Then I should see "Sleep journal for Alex"

  Scenario: navigating back to the welcome page
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I follow "home" within "header"
    Then I should see "Welcome"
