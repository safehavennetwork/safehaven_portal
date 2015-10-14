# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151014020239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", primary_key: "address_id", force: true do |t|
    t.text    "line1"
    t.text    "line2"
    t.integer "city_id"
    t.integer "state_id",    limit: 2
    t.integer "zip_code_id"
  end

  add_index "addresses", ["city_id"], name: "addresses_city_id_idx", using: :btree
  add_index "addresses", ["state_id"], name: "addresses_state_id_idx", using: :btree
  add_index "addresses", ["zip_code_id"], name: "addresses_zip_code_id_idx", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "advocate_applications", primary_key: "advocate_application_id", force: true do |t|
    t.integer "victim_id"
    t.integer "advocate_id"
    t.integer "status"
    t.text    "abuser_visiting_spots"
    t.text    "estimated_length_of_housing"
    t.boolean "police_involved",             default: false
    t.boolean "protective_order",            default: false
    t.boolean "pet_protective_order",        default: false
    t.boolean "client_legal_owner_of_pet",   default: false
    t.boolean "abuser_legal_owner_of_pet",   default: false
    t.boolean "explored_boarding_options",   default: false
    t.date    "created_at"
  end

  create_table "cities", primary_key: "city_id", force: true do |t|
    t.text "city", null: false
  end

  add_index "cities", ["city"], name: "cities__u_city", unique: true, using: :btree

  create_table "client_applications", primary_key: "client_application_id", force: true do |t|
    t.integer "client_id"
    t.integer "status"
    t.text    "abuser_visiting_spots"
    t.text    "estimated_length_of_housing"
    t.boolean "police_involved",             default: false
    t.boolean "protective_order",            default: false
    t.boolean "pet_protective_order",        default: false
    t.boolean "client_legal_owner_of_pet",   default: false
    t.boolean "abuser_legal_owner_of_pet",   default: false
    t.boolean "explored_boarding_options",   default: false
    t.date    "created_at"
    t.date    "updated_at"
    t.text    "abuser_notes"
  end

  create_table "clients", primary_key: "client_id", force: true do |t|
    t.text    "name"
    t.text    "email"
    t.text    "best_way_to_reach"
    t.integer "address_id"
    t.date    "created_at"
    t.integer "organization_id"
    t.date    "updated_at"
    t.text    "update_action"
    t.integer "pets_count"
    t.string  "slug"
    t.integer "release_status_id"
    t.integer "phone_number_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "groups", primary_key: "group_id", force: true do |t|
    t.text "name"
    t.text "description"
  end

  create_table "groups_users", primary_key: "groups_users_id", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "organization_statuses", primary_key: "organization_status_id", force: true do |t|
    t.text "organization_status", null: false
  end

  add_index "organization_statuses", ["organization_status"], name: "organization_statuses__u_organization_status", unique: true, using: :btree

  create_table "organization_types", primary_key: "organization_type_id", force: true do |t|
    t.text "organization_type", null: false
  end

  add_index "organization_types", ["organization_type"], name: "organization_types__u_organization_type", unique: true, using: :btree

  create_table "organizations", primary_key: "organization_id", force: true do |t|
    t.text    "name"
    t.text    "phone"
    t.integer "organization_type_id",   limit: 2
    t.integer "organization_status_id", limit: 2
    t.integer "address_id"
    t.date    "created_at"
    t.text    "code"
    t.integer "admin_id"
    t.date    "updated_at"
    t.text    "update_action"
    t.string  "email"
    t.string  "services"
    t.string  "office_hours"
    t.string  "website_url"
    t.string  "geographic_area_served"
    t.string  "slug"
    t.text    "tax_id"
  end

  create_table "organizations_clients", id: false, force: true do |t|
    t.integer "organization_id"
    t.integer "client_id"
  end

  create_table "pet_types", primary_key: "pet_type_id", force: true do |t|
    t.text "pet_type", null: false
  end

  add_index "pet_types", ["pet_type"], name: "pet_types__u_pet_type", unique: true, using: :btree

  create_table "pets", primary_key: "pet_id", force: true do |t|
    t.text    "name"
    t.text    "breed"
    t.integer "weight"
    t.text    "age"
    t.date    "reported"
    t.integer "client_id"
    t.integer "shelter_living_at_id"
    t.text    "description"
    t.boolean "microchipped",          default: false
    t.text    "micro_chip_id"
    t.boolean "abuser_at_mid_address", default: false
    t.boolean "vaccinations",          default: false
    t.boolean "spayed",                default: false
    t.boolean "objection_to_spay",     default: false
    t.text    "dietary_needs"
    t.text    "vet_needs"
    t.text    "temperament"
    t.text    "additional_info"
    t.integer "organization_id"
    t.integer "pet_type_id"
    t.date    "released_at"
    t.date    "relinguished_at"
    t.date    "updated_at"
    t.text    "update_action"
    t.boolean "completed"
    t.integer "release_status_id"
    t.string  "slug"
  end

  create_table "phone_number_types", primary_key: "phone_number_type_id", force: true do |t|
    t.text "phone_number_type", null: false
  end

  add_index "phone_number_types", ["phone_number_type"], name: "phone_number_types__u_phone_number_type", unique: true, using: :btree

  create_table "phone_numbers", primary_key: "phone_number_id", force: true do |t|
    t.text    "phone_number"
    t.integer "phone_number_type_id", limit: 2
  end

  create_table "release_statuses", primary_key: "release_status_id", force: true do |t|
    t.string "release_status"
  end

  create_table "states", primary_key: "state_id", force: true do |t|
    t.text "state", null: false
  end

  add_index "states", ["state"], name: "states__u_state", unique: true, using: :btree

  create_table "users", primary_key: "user_id", force: true do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "password"
    t.integer  "primary_phone_number_id"
    t.integer  "secondary_phone_number_id"
    t.integer  "organization_id"
    t.string   "email",                     default: "",                    null: false
    t.string   "encrypted_password",        default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "disabled",                  default: '2015-10-10 15:33:37'
    t.date     "updated_at"
    t.text     "update_action"
    t.date     "welcome_email_sent"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zip_codes", primary_key: "zip_code_id", force: true do |t|
    t.integer "zip_code", limit: 8
  end

end
