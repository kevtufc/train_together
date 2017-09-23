class WeeksController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = Date.today
    load_days
    render action: 'show'
  end

  def show
    @date = Date.parse(params[:date])
    load_days
  end

  private

  def load_days
    @days = current_user.plan_followers.map do |plan_follower|
      plan_follower.days_for @date
    end.flatten.sort_by(&:day_of_week)
  end
end
