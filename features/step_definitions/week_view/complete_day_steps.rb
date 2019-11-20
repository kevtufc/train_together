# frozen_string_literal: true

When(%r{^I complete the day ([\d/]+)$}) do |date|
  step("I view day #{date}")
  click_button('Complete')
  click_button('OK')
end

Then(/^day (\w+) shows as( not)? complete$/) do |day, not_complete|
  expect(page).to have_css(
    "#week_summary #{'.completed' unless not_complete}.step time",
    text: day
  )
end
