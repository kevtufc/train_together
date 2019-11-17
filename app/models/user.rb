class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :plan_followers, through: :teams
  has_many :plans, through: :teams
  has_many :days, through: :plans

  def current_plan_follower
    plan_followers.current.order(:start_date).first
  end

  def days_for(date)
    plan_followers.flat_map { |f| f.days_for(date) }
  end
end
