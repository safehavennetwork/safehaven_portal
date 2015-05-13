class AddOrgIdToPetsAndClients < ActiveRecord::Migration
  def change
    add_column :clients, :organization_id, :integer
    add_column :pets,    :organization_id, :integer
  end
end
