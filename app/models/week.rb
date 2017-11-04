class Week
  attr_accessor :week, :start_date

  def initialize(week:, start_date:)
    raise ArgumentError.new('Weeks must start on a Monday') unless start_date.monday?
    @start_date = start_date
    @week = week
  end

  def end_date
    start_date.sunday
  end

  def this_week?(date)
    (start_date..end_date).include? date
  end
end
