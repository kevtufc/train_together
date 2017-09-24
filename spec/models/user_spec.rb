require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  
  context 'following a plan' do
    let(:date) { Date.new(2017, 9, 4) }
    let(:team) { create(:team) }
    let(:plan) { create(:plan) }
    let(:plan_follower) { create(:plan_follower) }

    it { is_expected.to validate_presence_of :name }
    it { is_expected.to have_many :team_memberships }
    it { is_expected.to have_many :teams }
    it { is_expected.to have_many :plans }
    it { is_expected.to have_many :plan_followers }
    it { is_expected.to have_many :days }

    it 'gets the teams for a user' do
      user.teams << team
      expect(user.teams).to eq([team])
    end

    it 'gets the plans for a user' do
      user.teams << team
      plan.plan_followers << plan_follower
      team.plan_followers << plan_follower
      expect(user.plans).to eq([plan])
    end

    it 'gets the current plan follower for a user' do
      plan2 = create(:plan)
      user.teams << team
      pf = team.starts_following(plan, on: date)
      team.starts_following(plan2, on: date + 10.weeks)
      Timecop.travel(date)
      expect(user.current_plan_follower).to eq(pf)
      Timecop.return
    end
  end

  context 'with no followed plans' do
    it 'gets the plans for a user' do
      expect(user.plans).to eq([])
    end

    it 'gets the current plan follower for a user' do
      expect(user.current_plan_follower).to be_nil
    end
  end
end
