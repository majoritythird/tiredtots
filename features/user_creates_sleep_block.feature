Feature: User creates a sleep block

  Scenario: starting a new sleep block
    Given it is currently "Jan 1 2010"
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
    And I should see "Open sleep block"
    And I should see "Jan 1 2:15pm" in the "Start time" field

  Scenario: with chronic-friendly strings for the time
    Given it is currently "Jan 2 2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with "yesterday at 4pm"
    And I press "save"
    Then I should see "Jan 1 4:00pm" in the "Start time" field

  Scenario: finishing a sleep block
    Given it is currently "Jan 1 2010 4pm"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | Jan 1 2010 2:10pm |
      | finish_time |                   |
    When I go to the home page
    And I follow "Alex"
    Then I should see "Open sleep block"
    And I should see "Jan 1 2:10pm" in the "Start time" field
    When I fill in "Finish time" with "3:30pm"
    And I press "save"
    Then I should see "Sleep journal for Alex"
    And I should see a sleep block from 2:10pm to 3:30pm on Jan 1
    And I should see no data for 2:00pm on Jan 1

  Scenario: finishing a sleep block by providing a duration
    Given it is currently "Jan 1 2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | Jan 1 2010 2:10pm |
      | finish_time |                   |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Duration" with "1:40"
    And I press "save"
    Then I should see a sleep block from 2:10pm to 3:50pm on Jan 1
    When I follow "Jan  1"
    And I follow "Block 1"
    And I fill in "Finish time" with ""
    And I fill in "Duration" with "2 hours"
    And I press "save"
    Then I should see a sleep block from 2:10pm to 4:10pm on Jan 1
    When I follow "Jan  1"
    And I follow "Block 1"
    And I fill in "Finish time" with "3pm"
    And I fill in "Duration" with "2 hours"
    And I press "save"
    Then I should see "Please provide a finish time or a duration, but not both"
    And I fill in "Start time" with ""
    And I fill in "Finish time" with ""
    And I fill in "Duration" with "2 hours"
    And I press "save"
    Then I should see "Start time can't be blank"

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
    And I should see "monkey butter" in the "Start time" field
    And I should see "maybe doughnuts?" in the "Finish time" field

  Scenario: sleep blocks which end before they begin
    Given it is currently "Jan 1 2010"
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with "3pm"
    And I fill in "Finish time" with "2pm"
    And I press "save"
    Then I should see "Sleep can't end before it begins"
    And I should see "3pm" in the "Start time" field
    And I should see "2pm" in the "Finish time" field
    When I fill in "Start time" with "3pm"
    And I fill in "Finish time" with "3pm"
    And I press "save"
    Then I should see "Sleep can't end before it begins"

  Scenario: sleep blocks cannot overlap other sleep blocks
    Given it is currently "Jan 2 2010"
    Given I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep blocks:
      | start_time        | finish_time       |
      | Jan 1 2010 2:10pm | Jan 1 2010 4:10pm |
      | Jan 1 2010 7:40pm | Jan 2 2010 7:10am |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with "Jan 1 2pm"
    And I fill in "Finish time" with "Jan 1 3pm"
    And I press "save"
    Then I should see "Sleep can't overlap existing blocks of sleep"
    And I should see "Jan 1 2pm" in the "Start time" field
    And I should see "Jan 1 3pm" in the "Finish time" field
    When I fill in "Start time" with "Jan 1 2:30pm"
    And I fill in "Finish time" with "Jan 1 4:30pm"
    And I press "save"
    Then I should see "Sleep can't overlap existing blocks of sleep"
    When I fill in "Start time" with "Jan 1 4pm"
    And I fill in "Finish time" with "Jan 1 4:30pm"
    And I press "save"
    Then I should see "Sleep can't overlap existing blocks of sleep"
    When I fill in "Start time" with "Jan 1 7pm"
    And I fill in "Finish time" with "Jan 2 8am"
    And I press "save"
    Then I should see "Sleep can't overlap existing blocks of sleep"
    When I fill in "Start time" with "Jan 1 7pm"
    And I fill in "Finish time" with ""
    And I press "save"
    Then I should see "Sleep can't overlap existing blocks of sleep"
    When I fill in "Start time" with "Jan 2 4pm"
    And I fill in "Finish time" with "Jan 2 4:30pm"
    And I press "save"
    Then I should not see "Sleep can't overlap existing blocks of sleep"
    And I should see a sleep block from 4:00pm to 4:30pm on Jan 2

  Scenario: following a bookmark to sleep graph page when not signed in
    Given the following user:
      | email | user@example.com |
    And that user has the following child:
      | name | Alex |
    When I follow a bookmark to the sleep graph page for "Alex"
    Then I should see "You need to sign in or sign up before continuing."
    And I should not see "Sleep journal for Alex"

  Scenario: Bugfix: updating a time from a previous month
    Given it is currently "Nov 1 2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep blocks:
      | start_time      | finish_time     |
      | Oct 22 2010 8pm | Oct 23 2010 5am |
      | Oct 23 2010 1pm | Oct 23 2010 2pm |
    When I go to the home page
    And I follow "Alex"
    And I fill in "Start time" with "Oct 23 7pm"
    And I press "save"
    Then I should see "Open sleep block"
    And I should see "Oct 23 7:00pm" in the "Start time" field
