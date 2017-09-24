require 'rails_helper'

RSpec.describe Plan, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:days) }
  it { is_expected.to have_many(:followers) }

  it 'returns the length in weeks' do
    plan = create(:plan)
    plan.days << create(:day, week: 12)
    expect(plan.length).to eq(12)
  end
end
