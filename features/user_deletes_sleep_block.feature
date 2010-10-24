Feature: User deletes sleep block

  @wippp
  Scenario: deleting a finished sleep block
    Given it is currently "1/1/2010"
    And I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep block:
      | start_time  | 1/1/2010 2:15pm |
      | finish_time | 1/1/2010 3:30pm |
    When I go to the home page
    And I follow "Alex"

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
