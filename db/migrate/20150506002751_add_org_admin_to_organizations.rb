class AddOrgAdminToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :admin_id, :integer
  end
end
