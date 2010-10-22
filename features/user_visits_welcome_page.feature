Feature: User visits welcome page

  Scenario: when not signed in
    Given I am signed out
    When I go to the home page
    Then I should see "sign in"
    And I should see "sign up"
    And I should not see "To get started, add a child"
