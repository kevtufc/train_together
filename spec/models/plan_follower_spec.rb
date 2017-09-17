require 'rails_helper'

RSpec.describe PlanFollower, type: :model do
  let(:date) { Date.new(2017,1,1) }

  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:plan) }
  it { is_expected.to have_many(:days) }
  it { is_expected.to validate_presence_of(:team_id)    }
  it { is_expected.to validate_presence_of(:plan_id)    }
  it { is_expected.to validate_presence_of(:start_date) }

  it 'converts a date to a week number' do
    follower = create(:plan_follower, start_date: date)
    expect(follower.date_to_week_number(date)).to eq(1)
    expect(follower.date_to_week_number(date + 2.weeks)).to eq(3)
  end

  it 'converts a week_number to a date' do
    follower = create(:plan_follower, start_date: date)
    expect(follower.week_number_to_date(1)).to eq(date)
    expect(follower.week_number_to_date(3)).to eq(date + 2.weeks)
  end

  it 'gets the days for a date' do
    plan = create(:plan)
    days = [
      create(:day, week: 1),
      create(:day, week: 2),
      create(:day, week: 3),
      create(:day, week: 3)
    ]
    plan.days << days
    follower = create(:plan_follower, start_date: date, plan: plan)
    expect(follower.days_for(date + 1.week)).to eq([days[1]])
    expect(follower.days_for(date + 2.weeks)).to eq([days[2], days[3]])
  end
end
