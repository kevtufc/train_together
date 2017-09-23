module WeeksHelper
  def date_for(day)
    day.plan_follower.date_for(day)
  end

  def day_name_for(day)
    Date::DAYNAMES[day.day_of_week == 7 ? 0 : day.day_of_week]
  end
end
