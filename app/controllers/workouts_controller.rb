class WorkoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    Workout.create(user_id: params[:user_id], day_id: params[:day_id])
  end
end
