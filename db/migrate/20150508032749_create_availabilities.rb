class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :instructor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
