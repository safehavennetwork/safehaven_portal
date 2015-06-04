class ClientApplicationUpdates < ActiveRecord::Migration
  def up
    #drop_table :advocate_applications
    execute <<-SQL
    create table IF NOT EXISTS client_applications (
      client_application_id               bigint auto_increment not null,
      client_id                           bigint                        ,
      status                              integer                       ,
      abuser_visiting_spots               varchar(191)                  ,
      estimated_length_of_housing         varchar(191)                  ,
      police_involved                     tinyint(1) default 0          ,
      protective_order                    tinyint(1) default 0          ,
      pet_protective_order                tinyint(1) default 0          ,
      client_legal_owner_of_pet           tinyint(1) default 0          ,
      abuser_legal_owner_of_pet           tinyint(1) default 0          ,
      explored_boarding_options           tinyint(1) default 0          ,
      created_at                          datetime                      ,
      updated_at                          datetime                      ,
      constraint pk_client_applications primary key (client_application_id)
    );
    SQL
  end
end
