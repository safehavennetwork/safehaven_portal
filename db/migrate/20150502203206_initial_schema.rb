class InitialSchema < ActiveRecord::Migration
  def up
    execute 'create table IF NOT EXISTS cities    (city_id     bigint auto_increment not null, city     varchar(191), constraint pk_cities    primary key (city_id));'
    execute 'create table IF NOT EXISTS states    (state_id    bigint auto_increment not null, state    varchar(2),   constraint pk_states    primary key (state_id));'
    execute 'create table IF NOT EXISTS zip_codes (zip_code_id bigint auto_increment not null, zip_code smallint,     constraint pk_zip_codes primary key (zip_code_id));'

    execute <<-SQL
      create table IF NOT EXISTS addresses (
        address_id            bigint auto_increment not null,
        line1                 varchar(191),
        line2                 varchar(191),
        city_id               smallint,
        state_id              smallint,
        zip_code_id           smallint,
        constraint pk_address primary key (address_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS phone_number_types (
        phone_number_type_id             bigint auto_increment not null,
        phone_number_type                varchar(191),
        constraint pk_phone_number_types primary key (phone_number_type_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS phone_numbers (
        phone_number_id             bigint auto_increment not null,
        phone_number                varchar(191),
        phone_number_type_id        smallint,
        constraint pk_phone_numbers primary key (phone_number_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS organization_types (
        organization_type_id             bigint auto_increment not null,
        organization_type                varchar(191),
        constraint pk_organization_types primary key (organization_type_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS organization_statuses (
        organization_status_id               bigint auto_increment not null,
        organization_status                  varchar(191),
        constraint pk_organization_statuses primary key (organization_status_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS advocate_applications (
        advocate_application_id             bigint auto_increment not null,
        victim_id                           bigint,
        advocate_id                         bigint,
        status                              integer,
        abuser_visiting_spots               varchar(191),
        estimated_length_of_housing         varchar(191),
        police_involved                     tinyint(1) default 0,
        protective_order                    tinyint(1) default 0,
        pet_protective_order                tinyint(1) default 0,
        client_legal_owner_of_pet           tinyint(1) default 0,
        abuser_legal_owner_of_pet           tinyint(1) default 0,
        explored_boarding_options           tinyint(1) default 0,
        created_at                          datetime,
        constraint pk_advocate_applications primary key (advocate_application_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS organizations (
        organization_id            int auto_increment not null,
        name                       varchar(191),
        phone                      varchar(191),
        organization_type_id       smallint,
        organization_status_id     smallint,
        address_id                 bigint,
        created_at                datetime,
        constraint pk_organizations primary key (organization_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS pet_types (
        pet_type_id                bigint auto_increment not null,
        pet_type                   varchar(191),
        constraint pk_pet_types    primary key (pet_type_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS pets (
        pet_id                     bigint auto_increment not null,
        name                       varchar(191),
        pet_type                   integer,
        breed                      varchar(191),
        weight                     integer,
        age                        varchar(191),
        reported                   datetime,
        client_id                  bigint,
        shelter_living_at_id       bigint,
        description                varchar(191),
        microchipped               tinyint(1) default 0,
        micro_chip_id              varchar(191),
        abuser_at_mid_address      tinyint(1) default 0,
        vaccinations               tinyint(1) default 0,
        spayed                     tinyint(1) default 0,
        objection_to_spay          tinyint(1) default 0,
        dietary_needs              varchar(191),
        vet_needs                  varchar(191),
        temperament                varchar(191),
        additional_info            varchar(191),
        constraint pk_pets primary  key (pet_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS users (
        user_id                    bigint auto_increment not null,
        email                      varchar(191) not null,
        first_name                 varchar(191),
        last_name                  varchar(191),
        password                   varchar(191),
        primary_phone_number_id    int,
        secondary_phone_number_id  int,
        organization_id            bigint,
        constraint pk_users primary key (user_id)
      );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS clients (
        client_id                 bigint auto_increment not null,
        name                      varchar(191),
        phone                     varchar(191),
        email                     varchar(191),
        best_way_to_reach         varchar(191),
        address_id                bigint,
        created_at                datetime,
        constraint pk_clients     primary key (client_id)
        );
    SQL

    execute <<-SQL
      create table IF NOT EXISTS organizations_clients (
        organization_id  int,
        client_id        int
      );
    SQL
  end
end
