require 'rails_helper'

RSpec.describe "weeks/show.html.slim", type: :view do

  it 'shows the day titles' do
    assign(:days, [
      create(:day, day_of_week: 1, title: 'Day One'),
      create(:day, day_of_week: 2, title: 'Day Two'),
      create(:day, day_of_week: 3, title: 'Day Three')
    ] )
    render
    expect(rendered).to have_css('.day h3', text: 'Day One')
    expect(rendered).to have_css('.day h3', text: 'Day Two')
    expect(rendered).to have_css('.day h3', text: 'Day Three')
  end

  it 'shows a message if there\'s no plans this week' do
    render
    expect(rendered).to have_css('.day', count: 0)
    expect(rendered).to have_css('#week_summary', text: 'No plans this week')
  end
end
