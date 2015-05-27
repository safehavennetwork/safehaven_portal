class AddUserFields < ActiveRecord::Migration
  def change
    add_column :users, :updated_at,    :date
    add_column :users, :update_action, :text
  end
end
