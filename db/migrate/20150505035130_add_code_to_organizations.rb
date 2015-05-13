class AddCodeToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :code, :text
  end
end
