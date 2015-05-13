class CreateUsersGroups < ActiveRecord::Migration
  def change
    create_table :groups_users, primary_key: :groups_users_id do |t|
      t.integer :user_id
      t.integer :group_id
    end
  end
end
