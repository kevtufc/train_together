Then(/^save and open page$/) do
  save_and_open_page
end

Then(/^pry$/) do
  require 'pry'
  binding.pry
end

Then(/^I see the text "([^"]*)"$/) do |text|
  expect(page).to have_text text
end

When(/^I click "([^"]*)"$/) do |e|
  click_on e
end

Given(/^the date is (\d+)\/(\d+)\/(\d+)$/) do |day, month, year|
  Timecop.travel Date.new(year.to_i, month.to_i, day.to_i)
end
