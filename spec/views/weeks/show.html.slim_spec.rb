require 'rails_helper'

RSpec.describe "weeks/show.html.slim", type: :view do

  let(:plan_follower) { create(:plan_follower) }
  let(:days) do [
    create(:day, day_of_week: 1, title: 'Day One',   plan_follower: plan_follower),
    create(:day, day_of_week: 2, title: 'Day Two',   plan_follower: plan_follower),
    create(:day, day_of_week: 3, title: 'Day Three', plan_follower: plan_follower)
    ] end

  it 'shows the day titles' do
    assign(:days, days)
    assign(:date, plan_follower.start_date)
    render
    expect(rendered).to have_css('.day .title', text: 'Day One')
    expect(rendered).to have_css('.day .title', text: 'Day Two')
    expect(rendered).to have_css('.day .title', text: 'Day Three')
  end

  it 'shows a message if there\'s no plans this week' do
    render
    expect(rendered).to have_css('.day', count: 0)
    expect(rendered).to have_css('#week-summary', text: 'No plans this week')
  end
end