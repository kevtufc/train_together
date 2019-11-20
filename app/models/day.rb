class Day < ApplicationRecord
  belongs_to :plan
  has_many :workouts
  validates :day_of_week, presence: true, numericality: true, inclusion: 1..7
  validates :week, presence: true, numericality: true
  validates :title, presence: true

  attr_accessor :plan_follower

  def icon
    'calendar outline'
  end
end
