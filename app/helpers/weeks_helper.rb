module WeeksHelper
  def wday_to_name(wday)
    Date::DAYNAMES[wday == 7 ? 0 : wday]
  end
end
