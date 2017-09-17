FactoryGirl.define do
  factory :user do
    name 'John Lennon'
    email 'johnlennon@example.com'
    password 'password, man'
  end

  factory :team do
    title 'Team Beatles'
  end

  factory :plan do
    title 'Revolver Plan'
  end

  factory :plan_follower do
    start_date Date.new(2017, 9, 1)
    plan
    team
  end

  factory :day do
   week 1
   day_of_week 1
   title 'A Day'
   plan
  end
end
