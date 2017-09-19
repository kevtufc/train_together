require 'rails_helper'

RSpec.describe PlanFollower, type: :model do
  let(:date) { Date.new(2017, 1, 2) }
  let(:follower) { create(:plan_follower, start_date: date) }

  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:plan) }
  it { is_expected.to have_many(:days) }
  it { is_expected.to validate_presence_of(:team_id)    }
  it { is_expected.to validate_presence_of(:plan_id)    }
  it { is_expected.to validate_presence_of(:start_date) }

  # Start date must be a monday
  it { is_expected.to     allow_value(Date.new(2017,9, 18)).for(:start_date) } # Monday
  it { is_expected.not_to allow_value(Date.new(2017,9, 19)).for(:start_date) } # Tuesday

  it 'converts a date to a week number' do
    expect(follower.date_to_week_number(date)).to eq(1)
    expect(follower.date_to_week_number(date + 2.weeks)).to eq(3)
  end

  it 'converts a week number to a date' do
    expect(follower.week_number_to_date(1)).to eq(date)
    expect(follower.week_number_to_date(3)).to eq(date + 2.weeks)
  end

  it 'converts a week number and day to a date' do
    expect(follower.week_and_day_to_date(1, 1)).to eq(date)
    expect(follower.week_and_day_to_date(1, 3)).to eq(date + 2.days)
  end

  it 'gets the date for a planned day' do
    day  = follower.days.create(week: 1, day_of_week: 1)
    day2 = follower.days.create(week: 2, day_of_week: 1)
    expect(follower.date_for(day)).to  eq(date)
    expect(follower.date_for(day2)).to eq(date + 1.week)
  end

  it 'returns whether a day is planned for today' do
    day  = follower.days.create(week: 1, day_of_week: 1)
    Timecop.travel(date)
    expect(follower.today?(day)).to be_truthy
    Timecop.travel(date + 1.day)
    expect(follower.today?(day)).to be_falsey
    Timecop.return
  end

  # it 'converts a date to a week number and a day' do
  #   expect(follower.day_to_week_number_and_day(date)).to eq([1, 1])
  #   expect(follower.day_to_week_number_and_day(date + 2.days)).to eq([1, 3])
  # end

  # it 'returns how many days into a plan a date is' do
  #   expect(follower.day_number(date).to eq(0))
  #   expect(follower.day_number(date + 10.days)).to eq(10)
  #   expect(follower.day_number(date + 42.days)).to eq(42)
  # end

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
