class AddSlugs < ActiveRecord::Migration
  def change
    add_column :pets,    :slug, :string
    add_column :clients, :slug, :string
    add_column :users,   :slug, :string
  end
end
