require "rails_helper"

RSpec.describe WeeksHelper, type: :helper do
  let(:date) { Date.new(2017, 1, 2) }
  let(:plan_follower) { create(:plan_follower, start_date: date) }
  let(:day)  { create(:day, plan_follower: plan_follower) }

  describe "#date_for" do
    it "returns the date for a day" do
      expect(helper.date_for(day)).to eq(date)
    end
  end

  describe '#day_name_for' do
    it 'returns the day as a word' do
      expect(helper.day_name_for(day)).to eq('Monday')
    end
  end
end
