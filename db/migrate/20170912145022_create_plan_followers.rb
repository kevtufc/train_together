class CreatePlanFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :plan_followers do |t|
      t.references :plan, foreign_key: true
      t.references :team, foreign_key: true
      t.date       :start_date
      t.timestamps
    end
  end
end
