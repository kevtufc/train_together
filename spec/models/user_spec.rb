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
    it { is_expected.to have_many :workouts }

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

    it "gets the user's days for a week" do
      days = [
        create(:day, week: 1),
        create(:day, week: 2),
        create(:day, week: 3),
        create(:day, week: 3)
      ]
      plan.days << days
      follower = create(:plan_follower, start_date: date, plan: plan)
      user.teams << team
      team.plan_followers << follower
      expect(user.days_for(date + 1.week)).to eq([days[1]])
      expect(user.days_for(date + 2.weeks)).to eq([days[2], days[3]])
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
