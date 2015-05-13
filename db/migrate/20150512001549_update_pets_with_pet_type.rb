class UpdatePetsWithPetType < ActiveRecord::Migration
  def change
    remove_column :pets, :pet_type
    add_column :pets, :pet_type_id, :integer
  end
end
