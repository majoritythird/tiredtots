Feature: User deletes sleep block

  Scenario: deleting a finished sleep block
    Given it is currently "1/1/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 1/1/2010 2:10pm |
      | finish_time | 1/1/2010 3:30pm |
    When I go to the home page
    And I follow "Alex"
    And I follow "jan-1_2:10pm"
    And press "delete"
    Then I should see "Sleep journal for Alex"
    And I should not see a sleep block from 2:10pm to 3:30pm on Jan 1

  Scenario: deleting an unfinished sleep block
    Given it is currently "1/1/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 1/1/2010 2:15pm |
      | finish_time |                 |
    When I go to the home page
    And I follow "Alex"
    And I press "delete"
    Then I should see "Sleep journal for Alex"
    And I should see "New sleep block"
    And I should see nothing in the "Start time" field
