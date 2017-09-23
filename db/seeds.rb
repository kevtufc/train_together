kev = User.create name: 'Kev', email: 'kev@example.com', password: 'password'
team = Team.create title: 'Kev\'s Team'
kev.teams << team
plan = Plan.create title: 'Kev\'s Plan'

1.upto(10) do |week|
  plan.days << IndoorRide.create(title:  'Indoor Ride',    day_of_week: 1, week: week)
  plan.days << CrossTrain.create(title:  'Cross Training', day_of_week: 2, week: week)
  plan.days << IndoorRide.create(title: 'Indoor Ride',     day_of_week: 4, week: week)
  plan.days << OutdoorRide.create(title: 'Saturday Ride',  day_of_week: 6, week: week)
  plan.days << OutdoorRide.create(title: 'Club Ride',      day_of_week: 7, week: week)
  plan.days << RestDay.create(title: 'Rest Day', day_of_week: 3, week: week)
  plan.days << RestDay.create(title: 'Rest Day', day_of_week: 5, week: week)
end

team.starts_following(plan, on: Date.today.beginning_of_week)
