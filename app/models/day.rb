class Day < ApplicationRecord
  belongs_to :plan
  validates :day_of_week, presence: true, numericality: true, inclusion: 1..7
  validates :week, presence: true, numericality: true
  validates :title, presence: true

  def display_type
    self.class.name.humanize
  end
end
