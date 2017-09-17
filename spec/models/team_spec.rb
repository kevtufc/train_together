require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:team_memberships) }
  it { is_expected.to have_many(:members) }
  it { is_expected.to have_many(:plan_followers) }
  it { is_expected.to have_many(:plans) }

  let(:date) { Date.new(2017, 01, 01) }
  let(:plan) { create(:plan) }
  let(:team) { create(:team) }

  it 'starts following a plan' do
    ret = team.starts_following(plan, on: date)
    expect(PlanFollower.first).to have_attributes(plan_id: plan.id, team_id: team.id, start_date: date)
    expect(ret).to eq(team)
  end
end
