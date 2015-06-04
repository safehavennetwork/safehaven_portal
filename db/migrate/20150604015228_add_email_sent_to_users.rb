class AddEmailSentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :welcome_email_sent, :date
  end
end
