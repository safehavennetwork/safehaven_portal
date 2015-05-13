class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disabled, :date
  end
end
