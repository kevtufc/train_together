require 'rails_helper'

RSpec.describe WeeksController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user)          { create(:user)          }
  let(:team)          { create(:team)          }
  let(:date)          { Date.new(2017, 1, 2)   }
  let(:plan)          { create(:plan)          }
  let(:day_1) { create(:day, day_of_week: 1, title: 'Day One') }
  let(:day_2) { create(:day, day_of_week: 2, title: 'Day Two', id: 2) }
  let(:day_3) { create(:day, day_of_week: 3, title: 'Day Three') }
  let(:days) { [day_1, day_2, day_3] }

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

      it 'sets the plan_follower for the days' do
        get :show, params: { date: date }
        assigns(:days).each { |day| expect(day.plan_follower).to eq(plan.plan_followers.first) }
      end

      it 'selects the active_day' do
        get :show, params: { date: date + 1}
        expect(assigns(:day)).to eq(day_2)
      end

      it 'gets the weeks of the plans' do
        get :show, params: { date: date }
        expect(assigns(:weeks).length).to eq(1)
        expect(assigns(:weeks)).to all(be_a Week)
      end

      context 'with a few team members' do
        before(:each) do
          team.members << create_list(:user, 3)
        end

        it 'assigns the team members' do
          get :show, params: { date: date }
          expect(assigns(:team).members.length).to eq(4)
          team.members.each do |member|
            expect(assigns(:team).members).to include(member)
          end
        end

        it 'includes me in the team' do
          get :show, params: { date: date }
          expect(assigns(:team).members).to include(user)
        end
      end

      context '10 week long plan' do
        let(:day_3) { create(:day, week: 10, day_of_week: 3, title: 'Day Three') }

        it 'gets the weeks of the plans' do
          get :show, params: { date: date }
          expect(assigns(:weeks).length).to eq(10)
          expect(assigns(:weeks)).to all(be_a Week)
          expect(assigns(:weeks).first.start_date).to eq(date)
          expect(assigns(:weeks).last.start_date).to eq(date + 9.weeks)
        end
      end
    end
  end

  context 'not even logged in' do
    it 'redirects to the login page' do
      expect(get :index).to redirect_to(user_session_url)
    end
  end
end
