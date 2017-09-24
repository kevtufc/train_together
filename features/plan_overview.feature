Feature: Plan Overview
  The plan overview sits at the top of the page
  And shows you your progress through your plan

  Background:
    Given a user called "Kev" with email "kev@example.com" and password "password"
    And a plan called "Longer Plan" with these days:
      | title          | type         | week | day_of_week |
      | Rest           | RestDay      | 1    | 1           |
      | Ride           | OutdoorRide  | 1    | 2           |
      | Cross Training | CrossTrain   | 2    | 3           |
      | Pyramids       | IndoorRide   | 3    | 4           |
      | Rest           | RestDay      | 3    | 5           |
      | Ride           | OutdoorRide  | 4    | 6           |
      | Club Ride      | OutdoorRide  | 5    | 7           |
      | Club Ride      | OutdoorRide  | 6    | 7           |
    And a team called "Cheesey Team"
    And "Kev" is in team "Cheesey Team"
    And "Cheesey Team" is following "Longer Plan" from 06/02/2017
    And I log in with email "kev@example.com" and password "password"

  Scenario: See the plan overview
    When I view week 06/02/2017
    Then I see 6 weeks in the plan overview
