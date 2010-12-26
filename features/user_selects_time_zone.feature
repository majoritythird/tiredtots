Feature: User selects time zone

  Scenario: during sign up
    Given I am on the home page
    And I follow "sign up"
    When I fill in "Email" with "bob@example.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I select "Mountain Time (US & Canada)" from "Time zone"
    And I press "Sign up"
    Then I should see "You have signed up successfully"
    When I follow "profile"
    Then "Mountain Time (US & Canada)" should be selected for "Time zone"

  Scenario: when editing their profile
    Given I am signed in
    When I follow "profile"
    Then "Eastern Time (US & Canada)" should be selected for "Time zone"
    When I fill in "Current password" with "password"
    And I select "Pacific Time (US & Canada)" from "Time zone"
    And I press "Update"
    Then I should see "You updated your account successfully"
    When I follow "profile"
    Then "Pacific Time (US & Canada)" should be selected for "Time zone"
