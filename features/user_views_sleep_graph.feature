Feature: User views sleep graph

  Scenario: total hours asleep shown for each day
    Given it is currently "Jan 1 2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep blocks:
      | start_time        | finish_time       |
      | Jan 1 2010 2:00pm | Jan 1 2010 4:00pm |
      | Jan 1 2010 8:00pm | Jan 2 2010 7:00am |
      | Jan 2 2010 1:40pm | Jan 2 2010 3:20pm |
      | Jan 2 2010 7:40pm | Jan 3 2010 6:20am |
      | Jan 3 2010 1:50pm | Jan 3 2010 3:10pm |
      | Jan 3 2010 7:30pm | Jan 4 2010 6:10am |
    When I go to the home page
    And I follow "Sleep journal"
    Then I should see "6 hrs" on Jan 1
    And I should see "13 hrs" on Jan 2
    And I should see "12.2 hrs" on Jan 3
    And I should see "6.2 hrs" on Jan 4

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
    And I follow "Sleep journal"
    Then I should see a sleep block from 2:00pm to 4:00pm on Jan 1
    And I should see a sleep block from 8:00pm to 12:00pm on Jan 1
    And I should see a sleep block from 12:00am to 7:00am on Jan 2

  Scenario: navigating back to the welcome page
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Sleep journal"
    And I follow "home" within "header"
    Then I should see "Your children"

  @javascript
  Scenario: paging through older data
    Given it is currently "2010-02-11"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has 41 sleep blocks starting on "Jan 1 2010"
    When I go to the home page
    And I follow "Sleep journal"
    Then I should see one row for "Feb 10"
    And I should see one row for "Jan 22"
    And I should not see a row for "Jan 21"
    When I follow "view more sleep history"
    Then I should see one row for "Feb 10"
    And I should see one row for "Jan 21"
    And I should see one row for "Jan 2"
    And I should not see a row for "Jan 1"
    When I follow "view more sleep history"
    Then I should see one row for "Feb 10"
    And I should see one row for "Jan 1"
    And I should not see "view more sleep history"

  Scenario: On DST transition day, draw graph labels correcty
    Given it is currently "2010-11-07 at 8pm"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 2010-11-06 2pm |
      | finish_time | 2010-11-06 4pm |
    When I go to the home page
    And I follow "Sleep journal"
    Then I should see "11 pm"

  Scenario: On first day of standard time, render the 1am, 2am and 3am blocks once
    Given it is currently "2010-11-07 at 8pm"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 2010-11-07 2pm |
      | finish_time | 2010-11-07 4pm |
    When I go to the home page
    And I follow "Sleep journal"
    Then I should see only one block for 1am on Nov 7
    And I should see only one block for 2am on Nov 7
    And I should see only one block for 3am on Nov 7

  Scenario: On first day of daylight savings time, render the 1am, 2am and 3am blocks once
    Given it is currently "2010-03-14 at 8pm"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 2010-03-14 2pm |
      | finish_time | 2010-03-14 4pm |
    When I go to the home page
    And I follow "Sleep journal"
    Then I should see only one block for 1am on Mar 14
    And I should see only one block for 2am on Mar 14
    And I should see only one block for 3am on Mar 14
