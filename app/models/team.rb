class Team < ApplicationRecord
  validates :title, presence: true
  has_many :plan_followers
  has_many :plans, through: :plan_followers
  has_many :team_memberships
  has_many :members, through: :team_memberships, source: :user

  def starts_following(plan, on:)
    PlanFollower.create(team_id: id, plan_id: plan.id, start_date: on)
  end
end
