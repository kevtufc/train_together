require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { is_expected.to belong_to(:day) }
  it { is_expected.to belong_to(:user) }
end
