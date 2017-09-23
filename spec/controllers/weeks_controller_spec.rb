require 'rails_helper'

RSpec.describe WeeksController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user)          { create(:user)          }
  let(:team)          { create(:team)          }
  let(:plan_follower) { create(:plan_follower) }
  let(:date)          { Date.new(2017, 1, 2)   }
  let(:plan)          { create(:plan)          }
  let(:days) do [
      create(:day, day_of_week: 1, title: 'Day One'),
      create(:day, day_of_week: 3, title: 'Day Three'),
      create(:day, day_of_week: 2, title: 'Day Two')
    ]
  end

  context 'as a user set up in a team with a plan' do
    before(:each) do
      plan.days << days
      user.teams << team
      team.starts_following(plan, on: date)
      sign_in user
    end

    describe "GET #index" do
      it 'sets the current date' do
        Timecop.travel(date)
        get :index
        expect(assigns(:date)).to eq(date)
      end

      it 'gets the days for the week' do
        get :index
        expect(assigns(:days)).to match_array(days)
      end
    end

    describe 'GET #show' do
      it 'sets the date' do
        get :show, params: { date: date + 1.day }
        expect(assigns(:date)).to eq(date + 1.day)
      end

      it 'gets the days for the week' do
        get :show, params: { date: date }
        expect(assigns(:days)).to match_array(days)
      end

      it 'orders the days for the week' do
        get :show, params: { date: date }
        expect(assigns(:days)).to eq(days.sort_by(&:day_of_week))
      end
    end
  end

  context 'not even logged in' do
    it 'redirects to the login page' do
      expect(get :index).to redirect_to(user_session_url)
    end
  end
end
