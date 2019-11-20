require 'rails_helper'

RSpec.shared_examples 'a planned day' do

  let(:day) { create(:day) }

  it { is_expected.to validate_presence_of(:week) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:day_of_week) }
  it { is_expected.to validate_numericality_of(:day_of_week) }
  it { is_expected.to validate_numericality_of(:week) }
  it { is_expected.to validate_inclusion_of(:day_of_week).in_range(1..7)}
  it { is_expected.to belong_to :plan }
  it { is_expected.to have_many :workouts}
end

RSpec.describe Day, type: :model do
  it_behaves_like 'a planned day'
end

RSpec.describe RestDay, type: :model do
  it_behaves_like 'a planned day'
end

RSpec.describe OutdoorRide, type: :model do
  it_behaves_like 'a planned day'
end

RSpec.describe IndoorRide, type: :model do
  it_behaves_like 'a planned day'
end

RSpec.describe CrossTrain, type: :model do
  it_behaves_like 'a planned day'
end
