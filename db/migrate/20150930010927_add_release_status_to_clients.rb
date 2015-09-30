class AddReleaseStatusToClients < ActiveRecord::Migration
  def change
     add_column :clients, :release_status_id, :integer
  end
end
