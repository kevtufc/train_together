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
