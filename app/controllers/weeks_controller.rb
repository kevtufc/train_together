class WeeksController < ApplicationController
  def index
    @days = days_for Date.today
    render action: 'show'
  end

  def show
    @days = days_for(Date.parse(params[:date]))
  end

  private

  def days_for(date)
    current_user.plan_followers.map do |plan_follower|
      plan_follower.days_for date
    end.flatten
  end
end
