Feature: User views list of children

  Scenario: chart of sleep totals
    Given I am signed in
    And I have the following child:
      | name | Alex |
    And that child has the following sleep blocks:
      | start_time     | finish_time    |
      | Jan 1 2010 7pm | Jan 1 2010 9pm |
      | Jan 2 2010 7pm | Jan 2 2010 9pm |
      | Jan 3 2010 7pm | Jan 3 2010 9pm |
      | Jan 4 2010 7pm | Jan 4 2010 9pm |
      | Jan 5 2010 7pm | Jan 5 2010 9pm |
    When I go to the home page
    Then I should see the following table:
      | day   | total |
      | 01/02 | 2.0   |
      | 01/03 | 2.0   |
      | 01/04 | 2.0   |
