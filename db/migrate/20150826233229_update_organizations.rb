class UpdateOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :email                 , :string
    add_column :organizations, :services              , :string
    add_column :organizations, :office_hours          , :string
    add_column :organizations, :website_url           , :string
    add_column :organizations, :geographic_area_served, :string
  end
end
