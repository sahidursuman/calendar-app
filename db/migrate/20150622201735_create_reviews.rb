class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :student_id
      t.string :integer
      t.integer :instructor_id
      t.text :comment
      t.integer :rating

      t.timestamps null: false
    end
  end
end
