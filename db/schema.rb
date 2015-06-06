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

ActiveRecord::Schema.define(version: 20150604033110) do

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
    t.string  "line1",       limit: 191
    t.string  "line2",       limit: 191
    t.integer "city_id",     limit: 2
    t.integer "state_id",    limit: 2
    t.integer "zip_code_id", limit: 2
  end

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

  create_table "cities", primary_key: "city_id", force: true do |t|
    t.string "city", limit: 191
  end

  create_table "client_applications", primary_key: "client_application_id", force: true do |t|
    t.integer  "client_id",                   limit: 8
    t.integer  "status"
    t.string   "abuser_visiting_spots",       limit: 191
    t.string   "estimated_length_of_housing", limit: 191
    t.boolean  "police_involved",                         default: false
    t.boolean  "protective_order",                        default: false
    t.boolean  "pet_protective_order",                    default: false
    t.boolean  "client_legal_owner_of_pet",               default: false
    t.boolean  "abuser_legal_owner_of_pet",               default: false
    t.boolean  "explored_boarding_options",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "abuser_notes"
  end

  create_table "clients", primary_key: "client_id", force: true do |t|
    t.string   "name",              limit: 191
    t.string   "phone",             limit: 191
    t.string   "email",             limit: 191
    t.string   "best_way_to_reach", limit: 191
    t.integer  "address_id",        limit: 8
    t.datetime "created_at"
    t.integer  "organization_id"
    t.date     "updated_at"
    t.text     "update_action"
  end

  create_table "groups", primary_key: "group_id", force: true do |t|
    t.text "name"
    t.text "description"
  end

  create_table "groups_users", primary_key: "groups_users_id", force: true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "organization_statuses", primary_key: "organization_status_id", force: true do |t|
    t.string "organization_status", limit: 191
  end

  create_table "organization_types", primary_key: "organization_type_id", force: true do |t|
    t.string "organization_type", limit: 191
  end

  create_table "organizations", primary_key: "organization_id", force: true do |t|
    t.string   "name",                   limit: 191
    t.string   "phone",                  limit: 191
    t.integer  "organization_type_id",   limit: 2
    t.integer  "organization_status_id", limit: 2
    t.integer  "address_id",             limit: 8
    t.datetime "created_at"
    t.text     "code"
    t.integer  "admin_id"
    t.date     "updated_at"
    t.text     "update_action"
  end

  create_table "organizations_clients", id: false, force: true do |t|
    t.integer "organization_id"
    t.integer "client_id"
  end

  create_table "pet_types", primary_key: "pet_type_id", force: true do |t|
    t.string "pet_type", limit: 191
  end

  create_table "pets", primary_key: "pet_id", force: true do |t|
    t.string   "name",                  limit: 191
    t.string   "breed",                 limit: 191
    t.integer  "weight"
    t.string   "age",                   limit: 191
    t.datetime "reported"
    t.integer  "client_id",             limit: 8
    t.integer  "shelter_living_at_id",  limit: 8
    t.string   "description",           limit: 191
    t.boolean  "microchipped",                      default: false
    t.string   "micro_chip_id",         limit: 191
    t.boolean  "abuser_at_mid_address",             default: false
    t.boolean  "vaccinations",                      default: false
    t.boolean  "spayed",                            default: false
    t.boolean  "objection_to_spay",                 default: false
    t.string   "dietary_needs",         limit: 191
    t.string   "vet_needs",             limit: 191
    t.string   "temperament",           limit: 191
    t.string   "additional_info",       limit: 191
    t.integer  "organization_id"
    t.integer  "pet_type_id"
    t.date     "released_at"
    t.date     "relinguished_at"
    t.date     "updated_at"
    t.text     "update_action"
  end

  create_table "phone_number_types", primary_key: "phone_number_type_id", force: true do |t|
    t.string "phone_number_type", limit: 191
  end

  create_table "phone_numbers", primary_key: "phone_number_id", force: true do |t|
    t.string  "phone_number",         limit: 191
    t.integer "phone_number_type_id", limit: 2
  end

  create_table "states", primary_key: "state_id", force: true do |t|
    t.string "state", limit: 2
  end

  create_table "users", primary_key: "user_id", force: true do |t|
    t.string   "first_name",                limit: 191
    t.string   "last_name",                 limit: 191
    t.string   "password",                  limit: 191
    t.integer  "primary_phone_number_id"
    t.integer  "secondary_phone_number_id"
    t.integer  "organization_id",           limit: 8
    t.string   "email",                                 default: "",                    null: false
    t.string   "encrypted_password",                    default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,                     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "disabled",                              default: '2015-05-26 00:22:39'
    t.date     "updated_at"
    t.text     "update_action"
    t.date     "welcome_email_sent"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zip_codes", primary_key: "zip_code_id", force: true do |t|
    t.integer "zip_code", limit: 8
  end

end
