class Plan < ApplicationRecord
  has_many :days
  has_many :plan_followers
  has_many :followers, through: :plan_followers, source: :team
  validates :title, presence: true
end
