class AddCredentialExtraToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :credential_extra, :string
  end
end
