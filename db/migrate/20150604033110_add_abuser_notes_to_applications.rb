class AddAbuserNotesToApplications < ActiveRecord::Migration
  def change
    add_column :client_applications, :abuser_notes, :text
  end
end
