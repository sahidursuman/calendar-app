class AddAvatarToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :avatar, :string
  end
end
