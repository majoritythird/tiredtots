Feature: User views children list on welcome page

  Scenario: when not signed in
    Given I am signed out
    When I go to the home page
    Then I should see "sign in"
    And I should see "sign up"
    And I should not see "To get started, add a child"

  Scenario: viewing chart of recent sleep totals
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

  Scenario: sleep total chart does not display if child has no sleep tracked
    Given I am signed in
    And I have the following child:
      | name | Alex |
    When I go to the home page
    Then I should not see a chart
    And I should see "No sleep has been tracked yet."
