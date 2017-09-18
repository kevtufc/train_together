Given(/^a user called "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/) do |name, email, password|
  User.create(name: name, email: email, password: password)
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
