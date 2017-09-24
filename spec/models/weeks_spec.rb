require 'rails_helper'

RSpec.describe Week do
  context 'with valid attributes' do
    let(:start_date) { Date.new(2017,9,4) }
    let(:week_number) { 1 }
    let(:week) { Week.new(week: week_number, start_date: start_date) }

    describe '#initialize' do
      it 'creates a week' do
        expect(week).to be_a(Week)
      end

      it 'returns the week number' do
        expect(week.week).to eq(week_number)
      end

      it 'returns the start date' do
        expect(week.start_date).to eq(start_date)
      end
    end
  end

  context 'bad start date' do
    let(:start_date) { Date.new(2017,9,5) }
    let(:week_number) { 1 }
    let(:week) { Week.new(week: week_number, start_date: start_date) }

    describe '#initialize' do
      it 'throws an error because it should start on a Monday' do
        expect { week }.to raise_error(ArgumentError) 
      end
    end
  end

end
