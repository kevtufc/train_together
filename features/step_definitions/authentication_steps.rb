Given(/^a user called "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/) do |name, email, password|
  User.create(name: name, email: email, password: password)
end

Given(/^the following users:$/) do |users|
  users.hashes.each do |user|
    Team.find_or_create_by(title: user[:team]).members << create(:user, name: user[:name], email: user[:email], password: 'password')
  end
end

When(/I log in with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  visit user_session_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Login'
end

Then(/^I am logged in as "([^"]*)"$/) do |username|
  expect(page).to have_css('#topbar .current_user .username', text: /^#{username}/)
end

Then(/^I am not logged in$/) do
  # Doesn't do anything!
end

Then(/^I am redirected to the login page$/) do
  expect(page).to have_current_path(user_session_path)
end

When(/^I create a user called "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/) do |name, email, password|
  visit new_user_registration_path
  fill_in 'user_name', with: name
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password
  click_button 'Sign up'
end

Then(/^a user called "([^"]*)" should exist$/) do |name|
  expect(User.exists?(name: name)).to be_truthy
end
