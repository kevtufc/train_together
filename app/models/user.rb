class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :plan_followers, through: :teams
  has_many :plans, through: :teams
  has_many :days, through: :plans
end
