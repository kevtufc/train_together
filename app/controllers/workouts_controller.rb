# frozen_string_literal: true

class WorkoutsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:user_id].to_i == current_user.id
      Workout.create(user_id: params[:user_id], day_id: params[:day_id])
    else
      flash.alert = 'You may not add workouts for someone else!'
    end
  end
end
