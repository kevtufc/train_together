class PlanFollower < ApplicationRecord
  belongs_to :plan
  belongs_to :team
  has_many :days, through: :plan
  validates :plan_id, presence: true
  validates :team_id, presence: true
  validates :start_date, presence: true

  def date_to_week_number(date)
    ((date.beginning_of_week - start_date.beginning_of_week) / 7) + 1
  end

  def week_number_to_date(week_number)
    start_date + (week_number - 1).weeks
  end

  def days_for(date)
    days.where(week: date_to_week_number(date))
  end
end
