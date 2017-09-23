SimpleCov.start 'rails' do
  # Don't track the devise controllers for now
  add_filter '/controllers/users'

  # Don't track stuff I'm not using yet
  add_filter '/app/jobs'
  add_filter '/app/mailers'
  add_filter '/app/channels'
end
