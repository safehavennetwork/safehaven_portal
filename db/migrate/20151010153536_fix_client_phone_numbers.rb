class FixClientPhoneNumbers < ActiveRecord::Migration
  def change
    remove_column :clients, :phone
    add_column :clients, :phone_number_id, :integer
  end
end
