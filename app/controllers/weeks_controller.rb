class WeeksController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = Date.today
    load_days
    load_current_plan
    load_weeks
    load_team
    render action: 'show'
  end

  def show
    @date = Date.parse(params[:date])
    load_days
    load_current_plan
    load_weeks
    load_team
  end

  private

  def load_days
    @days = current_user.plan_followers.flat_map do |plan_follower|
      plan_follower.days_for(@date)
    end.sort_by(&:day_of_week)
    @day = @days.find { |day| day.plan_follower.date_for(day) == @date }
  end

  def load_weeks
    return @weeks = [] unless @plan
    @weeks = (1..(current_user.current_plan_follower.length)).map do |week|
      Week.new(
      week: week,
      start_date: current_user.current_plan_follower.start_date + (week - 1).weeks
    )
    end
  end

  def load_current_plan
    @plan = current_user.current_plan_follower.try(:plan)
  end

  def load_team
    @team = current_user.current_plan_follower.try(:team)
  end
end
