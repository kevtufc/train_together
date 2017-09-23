Feature: Week View
  The week view is the main dashboard for users.
  It shows planned and completed workouts for this, or another, week

  Background:
    Given a user called "Kev" with email "kev@example.com" and password "password"
    And a plan called "Simple Plan" with these days:
      | title     | type         | week | day_of_week |
      | Rest      | RestDay      | 1    | 1           |
      | Ride      | OutdoorRide  | 1    | 2           |
      | Cross     | CrossTrain   | 1    | 3           |
      | Pyramids  | IndoorRide   | 1    | 4           |
      | Rest      | RestDay      | 1    | 5           |
      | Ride      | OutdoorRide  | 1    | 6           |
      | Club Ride | OutdoorRide  | 1    | 7           |
      | Club Ride | OutdoorRide  | 2    | 7           |
    And a team called "Cool Team"
    And "Kev" is in team "Cool Team"
    And "Cool Team" is following "Simple Plan" from 02/01/2017
    And I log in with email "kev@example.com" and password "password"

  Scenario: View a week full of planned days
    When I view week 02/01/2017
    Then I see 2 days called "Rest"
    And I see 2 days called "Ride"
    And I see 1 day called "Club Ride"
    And I see 1 day called "Pyramids"
    And I see 1 day called "Cross"

    Scenario: View a week before the plan starts
    When I view week 2/12/2016
    Then I see no days
    And I see the text "No plans this week"

  Scenario: View a week with just one day
    When I view week 9/1/2017
    Then I see 1 day called "Club Ride"
    And I see 0 days called "Rest"
    And I see 0 days called "Pyramids"

  Scenario: I can move back and forward in weeks
    When I view week 2/1/2017
    Then I see a link to week 9/1/2017
    Then I see a link to week 26/12/2016

  Scenario: Current day is selected
    Given the date is 3/1/2017
    When I view week 2/1/2017
    Then the day 2/1/2017 is selected
