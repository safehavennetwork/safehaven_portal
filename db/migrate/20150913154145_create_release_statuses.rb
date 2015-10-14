class CreateReleaseStatuses < ActiveRecord::Migration
  def change
    create_table :release_statuses, primary_key: :release_status_id do |t|
      t.string :release_status
    end

    add_column :pets, :release_status_id, :integer
  end
end
