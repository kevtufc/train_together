Feature: Week View Teammates Panel
  In order to keep motivated
  As a user
  I can see my team-mates and what they have done this week

  Background:
    Given the following users:
      | name     | email                | team      |
      | Kev      | kev@example.com      | Cool Team |
      | Caroline | caroline@example.com | Cool Team |
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
    And "Cool Team" is following "Simple Plan" from 02/01/2017
    And I log in with email "kev@example.com" and password "password"

  Scenario: View teammates for a day
    When I view week 02/01/2017
    Then I see a team-mate called Caroline