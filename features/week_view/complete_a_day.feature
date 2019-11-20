Feature: Complete a day
  We need to sign off days as we progress through the plan

  Background:
    Given a user called "Kev" with email "kev@example.com" and password "password"
    And a plan called "Simple Plan" with these days:
      | title          | type         | week | day_of_week |
      | Rest           | RestDay      | 1    | 1           |
      | Ride           | OutdoorRide  | 1    | 2           |
      | Cross Training | CrossTrain   | 1    | 3           |
      | Pyramids       | IndoorRide   | 1    | 4           |
      | Rest           | RestDay      | 1    | 5           |
      | Ride           | OutdoorRide  | 1    | 6           |
      | Club Ride      | OutdoorRide  | 1    | 7           |
      | Club Ride      | OutdoorRide  | 2    | 7           |
    And a team called "Cool Team"
    And "Kev" is in team "Cool Team"
    And "Cool Team" is following "Simple Plan" from 02/01/2017
    And I log in with email "kev@example.com" and password "password"

  @javascript
  Scenario: Just signing off a day
    When I complete the day 03/1/2017
    Then day Tuesday shows as complete
    But day Monday shows as not complete
