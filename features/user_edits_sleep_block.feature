Feature: User edits sleep block

  Scenario: when multiple blocks overlap a day
    Given it is currently "1/4/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep blocks:
      | start_time     | finish_time    |
      | Jan 1 2010 7pm | Jan 2 2010 6am |
      | Jan 2 2010 1pm | Jan 2 2010 2pm |
      | Jan 2 2010 7pm | Jan 3 2010 6pm |
    When I go to the home page
    And I follow "Sleep journal"
    And I follow "Jan 2"
    Then I should see "Sleep blocks for 2010-01-02"
    When I follow "Jan 1 7:00pm - Jan 2 6:00am"
    And I fill in "Finish time" with "Jan 2 6:30am"
    And I press "save"
    Then I should see a sleep block from 12:00am to 6:30am on Jan 2
    When I follow "Jan 2"
    And I follow "Jan 2 1:00pm - Jan 2 2:00pm"
    And I fill in "Start time" with "Jan 2 1:30pm"
    And I fill in "Finish time" with "Jan 2 2:45pm"
    And I press "save"
    Then I should see a sleep block from 1:30pm to 2:45pm on Jan 2

  Scenario: canceling the edit of a sleep block
    Given I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | Jan 1 2010 2:10pm |
      | finish_time | Jan 1 2010 4:10pm |
    When I go to the home page
    And I follow "Sleep journal"
    And I follow "Jan 1"
    And I follow "cancel"
    Then I should be on the sleep journal page for Alex
    When I follow "Jan 1"
    And I follow "Jan 1 2:10pm - Jan 1 4:10pm"
    And I follow "cancel"
    Then I should be on the sleep journal page for Alex
