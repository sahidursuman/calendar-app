class CreateRepeatings < ActiveRecord::Migration
  def change
    create_table :repeatings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :instructor_id
      t.text :days_of_the_week

      t.timestamps null: false
    end
  end
end
