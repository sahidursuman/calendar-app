class AddCredentialToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :credential, :string
  end
end
