require 'rails_helper'

RSpec.describe User, type: :model do
    let(:date) { Date.new(2017, 9, 8) }
    let(:team) { create(:team) }
    let(:user) { create(:user) }
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
      expect(user.plans). to eq([plan])
    end
end
