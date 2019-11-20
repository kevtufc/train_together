class CreateWorkouts < ActiveRecord::Migration[5.1]
  def change
    create_table :workouts do |t|
      t.references :user, foreign_key: true
      t.references :day, foreign_key: true
    end
  end
end
