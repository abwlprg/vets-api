class ModifySavedClaims < ActiveRecord::Migration
  def change
    rename_column :saved_claims, :form_type, :form_id
    add_column :saved_claims, :type, :string
  end
end
