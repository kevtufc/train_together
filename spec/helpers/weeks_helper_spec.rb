require "rails_helper"

RSpec.describe WeeksHelper, type: :helper do
  let(:date) { Date.new(2017, 1, 2) }
  let(:plan_follower) { create(:plan_follower, start_date: date) }
  let(:day)  { create(:day, plan_follower: plan_follower) }

  before(:each) do
  end

  describe "#date_for" do
    it "returns the date for a day" do
      expect(helper.date_for(day)).to eq(date)
    end
  end
end
