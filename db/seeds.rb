kev = User.create name: 'Kev', email: 'kev@example.com', password: 'password'
team = Team.create title: 'Kev\'s Team'
kev.teams << team
plan = Plan.create title: 'Kev\'s Plan'

1.upto(10) do |week|
  plan.days << IndoorRide.create(title:  'Indoor Ride',    day_of_week: 1, week: week)
  plan.days << CrossTrain.create(title:  'Cross Training', day_of_week: 2, week: week)
  plan.days << IndoorRide.create(title: 'Indoor Ride',     day_of_week: 4, week: week)
  plan.days << OutdoorRide.create(title: 'Club Ride',      day_of_week: 7, week: week)
  plan.days << RestDay.create(title: 'Rest Day', day_of_week: 3, week: week)
  plan.days << RestDay.create(title: 'Rest Day', day_of_week: 5, week: week)
  plan.days << OutdoorRide.create do |day|
    day.week = week
    day.title = 'Saturday Ride'
    day.day_of_week = 6
    day.description = <<~END
      <h1>Big Saturday Ride</h1>
      <p>
        Some description about the Big Saturday Ride. Something nice and interesting.
        Blah blah blah blah blah.
      </p>
      <p>
        During this session you may want to do the following things:
        <ul>
          <li>Ride your bike</li>
          <li>Ride it some more</li>
          <li>Avoid falling off</li>
        </ul>
      </p>
      <h2>Once you've finished</h2>
      <p>
        Put normal clothes on and eat a cake.  <ul>
          <li>Ride your bike</li>
          <li>Ride it some more</li>
          <li>Avoid falling off</li>
        </ul>

      </p>
    END
  end
end

team.starts_following(plan, on: Date.today.beginning_of_week)
