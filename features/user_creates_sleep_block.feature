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
    Given it is currently "Jan 1 2010"
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

  Scenario: sleep graph displays a row for all days with data
    Given it is currently "Jan 2 2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep blocks:
      | start_time        | finish_time       |
      | Jan 1 2010 2:00pm | Jan 1 2010 4:00pm |
      | Jan 1 2010 8:00pm | Jan 2 2010 7:00am |
    When I go to the home page
    And I follow "Alex"
    Then I should see a sleep block from 2:00pm to 4:00pm on Jan 1
    And I should see a sleep block from 8:00pm to 12:00pm on Jan 1
    And I should see a sleep block from 12:00am to 7:00am on Jan 2

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
    When I follow "jan-1_2:10pm"
    And I fill in "Finish time" with ""
    And I fill in "Duration" with "2 hours"
    And I press "save"
    Then I should see a sleep block from 2:10pm to 4:10pm on Jan 1
    When I follow "jan-1_2:10pm"
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
    And I should see "Jan 1 2:00pm" in the "Finish time" field
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
    And I should see "Jan 1 3:00pm" in the "Finish time" field
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

  Scenario: canceling the edit of a sleep block
    Given I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | Jan 1 2010 2:10pm |
      | finish_time | Jan 1 2010 4:10pm |
    When I go to the home page
    And I follow "Alex"
    And I follow "jan-1_2:10pm"
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
