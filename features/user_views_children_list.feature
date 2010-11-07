Feature: User views list of children

  Scenario: chart of sleep totals
    Given I am signed in
    And I have the following child:
      | name | Alex |
    And that child has 25 sleep blocks starting on "2010-01-01"
    When I go to the home page
    Then I should see the following table:
      | day   | total |
      | 01/05 | 1.0   |
      | 01/06 | 1.0   |
      | 01/07 | 1.0   |
      | 01/08 | 1.0   |
      | 01/09 | 1.0   |
      | 01/10 | 1.0   |
      | 01/11 | 1.0   |
      | 01/12 | 1.0   |
      | 01/13 | 1.0   |
      | 01/14 | 1.0   |
      | 01/15 | 1.0   |
      | 01/16 | 1.0   |
      | 01/17 | 1.0   |
      | 01/18 | 1.0   |
      | 01/19 | 1.0   |
      | 01/20 | 1.0   |
      | 01/21 | 1.0   |
      | 01/22 | 1.0   |
      | 01/23 | 1.0   |
      | 01/24 | 1.0   |
      | 01/25 | 1.0   |
