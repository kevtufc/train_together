require 'rails_helper'

RSpec.describe WorkoutsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user)          { create(:user)          }
  let(:team)          { create(:team)          }
  let(:date)          { Date.new(2017, 1, 2)   }
  let(:plan)          { create(:plan)          }
  let(:day) { create(:day, day_of_week: 1, title: 'Test Day') }

  context 'as a user set up in a team with a plan' do
    before(:each) do
      plan.days << day
      user.teams << team
      team.starts_following(plan, on: date)
      sign_in user
    end

    describe 'POST #index' do
      it 'creates a new workout for me' do
        expect do
          post :create, params: { user_id: user.id, day_id: day.id }
        end.to change { Workout.count }.by(1)

        new_workout = Workout.first
        expect(new_workout).to have_attributes(user_id: user.id, day_id: day.id)
        expect(user.workouts.first).to eq(new_workout)
        expect(day.workouts.first).to  eq(new_workout)
        expect(flash.notice).not_to be_present
      end

      it 'rejects new workouts for someone else' do
        expect do
          post :create, params: { user_id: create(:user).id, day_id: day.id }
        end.not_to change { Workout.count }
        expect(flash.alert).to be_present
      end

      it 'rejects new workout for non-existent users' do
        expect do
          post :create, params: { user_id: 999, day_id: day.id }
        end.not_to change { Workout.count }
      end
    end
  end
end
