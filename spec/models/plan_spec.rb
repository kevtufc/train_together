require 'rails_helper'

RSpec.describe Plan, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:days) }
  it { is_expected.to have_many(:followers) }
end
