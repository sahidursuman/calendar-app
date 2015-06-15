class CreateRepeatingAvailabilities < ActiveRecord::Migration
  def change
    create_table :repeating_availabilities do |t|
      t.integer :start_time
      t.integer :end_time
      t.text :days_of_the_week
      t.integer :instructor_id

      t.timestamps null: false
    end
  end
end
