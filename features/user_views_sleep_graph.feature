Feature: User views sleep graph

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

  Scenario: navigating back to the welcome page
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    And I follow "Alex"
    And I follow "home" within "header"
    Then I should see "Welcome"
