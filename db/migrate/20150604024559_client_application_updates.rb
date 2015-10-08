class ClientApplicationUpdates < ActiveRecord::Migration
  def up
    #drop_table :advocate_applications
    execute <<-SQL
    create table client_applications (
      client_application_id               SERIAL PRIMARY KEY,
      client_id                           integer,
      status                              integer,
      abuser_visiting_spots               text,
      estimated_length_of_housing         text,
      police_involved                     BOOLEAN default false,
      protective_order                    BOOLEAN default false,
      pet_protective_order                BOOLEAN default false,
      client_legal_owner_of_pet           BOOLEAN default false,
      abuser_legal_owner_of_pet           BOOLEAN default false,
      explored_boarding_options           BOOLEAN default false,
      created_at                          date,
      updated_at                          date
    );
    SQL
  end
end
