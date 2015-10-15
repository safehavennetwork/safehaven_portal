class AddAgreeToTermsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agree_to_terms, :boolean
  end
end
