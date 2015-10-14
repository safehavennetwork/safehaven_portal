class AddCompletedToPets < ActiveRecord::Migration
  def change
    add_column :pets, :completed, :boolean
  end
end
