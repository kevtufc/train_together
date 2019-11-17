class PlanFollower < ApplicationRecord
  belongs_to :plan
  belongs_to :team
  has_many :days, through: :plan
  validates :plan_id, presence: true
  validates :team_id, presence: true
  validates :start_date, presence: true
  validate  :start_date_must_be_a_monday
  delegate :length, to: :plan

  scope :current, -> { where("start_date <= ?", Date.today) }

  def date_to_week_number(date)
    ((date.beginning_of_week - start_date.beginning_of_week) / 7) + 1
  end

  def week_number_to_date(week_number)
    start_date + (week_number - 1).weeks
  end

  def week_and_day_to_date(week_number, day)
    week_number_to_date(week_number) + (day - 1).days
  end

  def days_for(date)
    the_days = days.where(week: date_to_week_number(date))
    the_days.each { |day| day.plan_follower = self }
    the_days
  end

  def date_for(day)
    week_and_day_to_date(day.week, day.day_of_week)
  end

  def today?(day)
    date_for(day).today?
  end

  def end_date
    date_for(days.order(:week, :day_of_week).last)
  end

  private

  def start_date_must_be_a_monday
    return unless start_date
    errors.add(:start_date, 'must be a monday') unless start_date == start_date.monday
  end
end
