class DefaultUserDisabled < ActiveRecord::Migration
  def change
    change_column :users, :disabled, :datetime, default: Time.now
  end
end
