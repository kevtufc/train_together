class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.references :plan, foreign_key: true
      t.integer :week
      t.integer :day_of_week
      t.string :type
      t.string :title
      t.string :description
      t.integer :minutes
      t.integer :meters
      t.timestamps
    end
  end
end
