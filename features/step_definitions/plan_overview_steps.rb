Then(/^I see (\d+) weeks in the plan overview$/) do |count|
  expect(page).to have_css('#plan-overview .week', count: count)
end

When(/^I click "([^"]*)" in the week overview$/) do |week_number|
  find('#plan-overview').click_link(week_number)
end
