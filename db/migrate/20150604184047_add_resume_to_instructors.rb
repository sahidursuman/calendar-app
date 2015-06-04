class AddResumeToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :resume, :string
  end
end
