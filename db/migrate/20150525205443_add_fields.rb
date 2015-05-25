class AddFields < ActiveRecord::Migration
  def change
    add_column :pets,          :released_at,     :date
    add_column :pets,          :relinguished_at, :date

    add_column :pets,          :updated_at,  :date
    add_column :clients,       :updated_at,  :date
    add_column :organizations, :updated_at,  :date

    add_column :pets,          :update_action, :text
    add_column :clients,       :update_action, :text
    add_column :organizations, :update_action, :text
  end
end
