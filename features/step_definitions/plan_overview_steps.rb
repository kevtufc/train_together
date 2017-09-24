Then(/^I see (\d+) weeks in the plan overview$/) do |count|
  expect(page).to have_css('#plan-overview .week', count: count)
end
