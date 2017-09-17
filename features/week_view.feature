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
    And a team called "Cool Team"
    And "Kev" is in team "Cool Team"
    And "Cool Team" is following "Simple Plan" from 01/01/2017
    And I log in with email "kev@example.com" and password "password"

  Scenario:
    And I view week 01/01/2017
    Then I see 2 days called "Rest"
    And I see 2 days called "Ride"
    And I see 1 day called "Club Ride"
    And I see 1 day called "Pyramids"
    And I see 1 day called "Cross"
