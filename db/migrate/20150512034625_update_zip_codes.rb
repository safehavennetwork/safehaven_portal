class UpdateZipCodes < ActiveRecord::Migration
  def change
    remove_column :zip_codes, :zip_code
    add_column :zip_codes, :zip_code, :bigint
  end
end
