module WeeksHelper
  def date_for(day)
    day.plan_follower.date_for(day)
  end
end
