class AddPetsCounterCache < ActiveRecord::Migration
  def change
    add_column :clients, :pets_count, :integer
  end
end
