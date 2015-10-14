class InitialSchema < ActiveRecord::Migration
  def up
    with_options small: true do |t|
      t.create_lookup_table :cities
      t.create_lookup_table :states
      t.create_lookup_table :zip_codes
      t.create_lookup_table :phone_number_types
      t.create_lookup_table :organization_types
      t.create_lookup_table :organization_statuses
      t.create_lookup_table :pet_types
    end

    execute <<-SQL
      create table addresses (
        address_id            SERIAL PRIMARY KEY,
        line1                 TEXT,
        line2                 TEXT,
        city_id               INTEGER  REFERENCES cities,
        state_id              SMALLINT REFERENCES states,
        zip_code_id           INTEGER  REFERENCES zip_codes
      );
      CREATE INDEX ON addresses (city_id);
      CREATE INDEX ON addresses (state_id);
      CREATE INDEX ON addresses (zip_code_id);
    SQL

    execute <<-SQL
      CREATE TABLE phone_numbers (
        phone_number_id      SERIAL   PRIMARY KEY,
        phone_number         TEXT,
        phone_number_type_id SMALLINT REFERENCES phone_number_types
      );
    SQL

    execute <<-SQL
      create table advocate_applications (
        advocate_application_id             SERIAL PRIMARY KEY,
        victim_id                           integer,
        advocate_id                         integer,
        status                              integer,
        abuser_visiting_spots               text,
        estimated_length_of_housing         text,
        police_involved                     BOOLEAN default false,
        protective_order                    BOOLEAN default false,
        pet_protective_order                BOOLEAN default false,
        client_legal_owner_of_pet           BOOLEAN default false,
        abuser_legal_owner_of_pet           BOOLEAN default false,
        explored_boarding_options           BOOLEAN default false,
        created_at                          date
      );
    SQL

    execute <<-SQL
      create table organizations (
        organization_id            SERIAL PRIMARY KEY,
        name                       text,
        phone                      text,
        organization_type_id       smallint,
        organization_status_id     smallint,
        address_id                 integer,
        created_at                 date
      );
    SQL

    execute <<-SQL
      create table pets (
        pet_id                     SERIAL PRIMARY KEY,
        name                       text,
        pet_type                   integer,
        breed                      text,
        weight                     integer,
        age                        text,
        reported                   date,
        client_id                  integer,
        shelter_living_at_id       integer,
        description                text,
        microchipped               boolean default false,
        micro_chip_id              text,
        abuser_at_mid_address      boolean default false,
        vaccinations               boolean default false,
        spayed                     boolean default false,
        objection_to_spay          boolean default false,
        dietary_needs              text,
        vet_needs                  text,
        temperament                text,
        additional_info            text
      );
    SQL

    execute <<-SQL
      create table users (
        user_id                    SERIAL PRIMARY KEY,
        email                      text not null,
        first_name                 text,
        last_name                  text,
        password                   text,
        primary_phone_number_id    integer,
        secondary_phone_number_id  integer,
        organization_id            integer
      );
    SQL

    execute <<-SQL
      create table clients (
        client_id                 SERIAL PRIMARY KEY,
        name                      text,
        phone                     text,
        email                     text,
        best_way_to_reach         text,
        address_id                integer,
        created_at                date
        );
    SQL

    execute <<-SQL
      create table organizations_clients (
        organization_id  integer,
        client_id        integer
      );
    SQL
  end
end
