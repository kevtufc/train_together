require 'rails_helper'

RSpec.describe "weeks/show.html.slim", type: :view do

  let(:plan_follower) { create(:plan_follower) }
  let(:date) { plan_follower.start_date }

  before(:each) do
    assign(:days, days)
    assign(:date, date)
    render
  end

  context 'with plans this week' do
    let(:days) do [
      create(:day, day_of_week: 1, title: 'Day One',   plan_follower: plan_follower),
      create(:day, day_of_week: 2, title: 'Day Two',   plan_follower: plan_follower),
      create(:day, day_of_week: 3, title: 'Day Three', plan_follower: plan_follower)
    ] end

    it 'shows the day titles' do
      expect(rendered).to have_css('.day .title', text: 'Day One')
      expect(rendered).to have_css('.day .title', text: 'Day Two')
      expect(rendered).to have_css('.day .title', text: 'Day Three')
    end

    it 'shows the days (with the dates in the attrs)' do
      expect(rendered).to have_css(".day time[datetime='#{date.to_s(:db)}']", text: 'Monday')
    end

    it 'shows the current week date' do
      expect(rendered).to have_text(date.strftime('%d'))
      expect(rendered).to have_text(date.strftime('%B'))
      expect(rendered).to have_text(date.strftime('%Y'))
    end

    it 'shows links to previous and next weeks' do
      expect(rendered).to have_link('next week', href: week_path(date + 1.week))
      expect(rendered).to have_link('previous week', href: week_path(date - 1.week))
    end
  end

  context 'no plans this week' do
    let (:days) { [] }

    it 'shows a message if' do
      expect(rendered).to have_css('.day', count: 0)
      expect(rendered).to have_css('#week-summary', text: 'No plans this week')
    end
  end
end
