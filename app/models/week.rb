class Week
  attr_accessor :week, :start_date

  def initialize(week:, start_date:)
    raise ArgumentError.new('Weeks must start on a Monday') unless start_date.monday?
    @start_date = start_date
    @week = week
  end
end
