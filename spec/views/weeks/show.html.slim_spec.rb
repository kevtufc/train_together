require 'rails_helper'

RSpec.describe "weeks/show.html.slim", type: :view do

  let(:plan_follower) { create(:plan_follower) }
  let(:date) { plan_follower.start_date }
  let(:day_1) { create(:day, plan_follower: plan_follower, day_of_week: 1, title: 'Day One', description: "Wibbler") }
  let(:day_2) { create(:day, plan_follower: plan_follower, day_of_week: 2, title: 'Day Two', id: 2) }
  let(:day_3) { create(:day, plan_follower: plan_follower, day_of_week: 3, title: 'Day Three') }
  let(:days) { [day_1, day_2, day_3] }
  let(:weeks) { [Week.new(week: 1, start_date: date)]  }
  let(:plan) { create(:plan) }


  before(:each) do
    assign(:plan, plan)
    assign(:days, days)
    assign(:day, day_1)
    assign(:date, date)
    assign(:weeks, weeks)
    render
  end

  it 'shows the plan overview' do
    expect(rendered).to have_css('#plan-overview .week', count: 1)
  end

  it 'links plan overview buttons to the weeks' do
    expect(rendered).to have_css("a.week[href='#{week_path(date: date)}']")
  end

  it 'has the week number on the plan overview buttons' do
    expect(rendered).to have_css('a.week', text: weeks.first.week)
  end

  context 'with plans this week' do
    it 'shows the day titles' do
      expect(rendered).to have_css('.day .title', text: 'Day One')
      expect(rendered).to have_css('.day .title', text: 'Day Two')
      expect(rendered).to have_css('.day .title', text: 'Day Three')
    end

    it 'shows the days (with the dates in the attrs)' do
      expect(rendered).to have_css(".day time[datetime='#{date.to_s(:db)}']", text: 'Monday')
      expect(rendered).to have_css(".day time[datetime='#{(date + 1.day).to_s(:db)}']", text: 'Tuesday')
      expect(rendered).to have_css(".day time[datetime='#{(date + 2.days).to_s(:db)}']", text: 'Wednesday')
    end

    it 'has links for the day details' do
      expect(rendered).to have_css("a.step[href='#{week_path(date: date)}']")
      expect(rendered).to have_css("a.step[href='#{week_path(date: date + 1.day)}']")
    end

    it 'shows the current week date' do
      expect(rendered).to have_css('#current-week-date', text: date.strftime('%d %B %Y'))
    end

    it 'shows links to previous and next weeks' do
      expect(rendered).to have_link('next week', href: week_path(date + 1.week))
      expect(rendered).to have_link('previous week', href: week_path(date - 1.week))
    end

    it 'shows the details for the selected day' do
      expect(rendered).to have_css('#selected-day h2', text: 'Day One' )
      expect(rendered).to have_css('#selected-day p', text: 'Wibbler' )
    end
  end

  context 'no plans this week' do
    let(:days) { [] }
    let(:weeks) { [] }
    it 'shows a message if' do
      expect(rendered).to have_css('.day', count: 0)
      expect(rendered).to have_css('#week-summary', text: 'No plans this week')
    end

    it 'doesn\'t show the plan overview' do
      expect(rendered).to_not have_css('#plan-overview')
    end
  end
end
