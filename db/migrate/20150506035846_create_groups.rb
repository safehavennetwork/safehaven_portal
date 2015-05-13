class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups, primary_key: :group_id do |t|
      t.text :name
      t.text :description
    end
  end
end
