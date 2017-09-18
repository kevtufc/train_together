Given(/^a plan called "([^"]*)" with these days:$/) do |title, days|
  plan = Plan.create(title: title)
  plan.days << days.hashes.map{ |day| Day.create(day) }
end

Given(/^a team called "([^"]*)"$/) do |team|
  Team.create(title: team)
end

Given(/^"([^"]*)" is in team "([^"]*)"$/) do |user, team|
  Team.where(title: team).first.members << User.where(name: user).first
end

Given(/^"([^"]*)" is following "([^"]*)" from (\d+)\/(\d+)\/(\d+)$/) do |team, plan, day, month, year|
  Team.where(title: team).first.starts_following(Plan.where(title: plan).first, on: Date.new(year.to_i, month.to_i, day.to_i))
end

When(/^I view week (\d+)\/(\d+)\/(\d+)$/) do |day, month, year|
  visit weeks_path(date: Date.new(year.to_i, month.to_i, day.to_i))
end

Then(/^I see (\d+) days? called "([^"]*)"$/) do |count, title|
  expect(page).to have_css('.day h4', text: /^#{title}$/, count: count)
end

Then(/^I see no days$/) do
  expect(page).to_not have_css('.day')
end
