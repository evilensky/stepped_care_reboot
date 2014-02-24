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

ActiveRecord::Schema.define(version: 20140224031252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "participant_id",                                     null: false
    t.integer  "activity_type_id",                                   null: false
    t.datetime "start_time",                                         null: false
    t.datetime "end_time",                                           null: false
    t.integer  "actual_accomplishment_intensity"
    t.integer  "actual_pleasure_intensity"
    t.integer  "predicted_accomplishment_intensity"
    t.integer  "predicted_pleasure_intensity"
    t.boolean  "is_complete",                        default: false, null: false
    t.text     "noncompliance_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["activity_type_id"], name: "index_activities_on_activity_type_id", using: :btree
  add_index "activities", ["participant_id"], name: "index_activities_on_participant_id", using: :btree

  create_table "activity_types", force: true do |t|
    t.integer  "participant_id"
    t.string   "title",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_types", ["participant_id"], name: "index_activity_types_on_participant_id", using: :btree

  create_table "awake_periods", force: true do |t|
    t.integer  "participant_id", null: false
    t.datetime "start_time",     null: false
    t.datetime "end_time",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "awake_periods", ["participant_id"], name: "index_awake_periods_on_participant_id", using: :btree

  create_table "content_modules", force: true do |t|
    t.string  "title",                null: false
    t.string  "context",              null: false
    t.integer "position", default: 1, null: false
  end

  create_table "content_providers", force: true do |t|
    t.string   "type",                            null: false
    t.string   "source_content_type"
    t.integer  "source_content_id"
    t.integer  "content_module_id",               null: false
    t.integer  "position",            default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_providers", ["content_module_id"], name: "index_content_providers_on_content_module_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "title",      null: false
    t.integer  "creator_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["title"], name: "index_groups_on_title", unique: true, using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "group_id",       null: false
    t.integer  "participant_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id", "participant_id"], name: "index_memberships_on_group_id_and_participant_id", unique: true, using: :btree
  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["participant_id"], name: "index_memberships_on_participant_id", using: :btree

  create_table "participants", force: true do |t|
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

  add_index "participants", ["email"], name: "index_participants_on_email", unique: true, using: :btree
  add_index "participants", ["reset_password_token"], name: "index_participants_on_reset_password_token", unique: true, using: :btree

  create_table "slides", force: true do |t|
    t.string   "title"
    t.text     "body",                     null: false
    t.integer  "position",     default: 1, null: false
    t.integer  "slideshow_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "slides", ["slideshow_id"], name: "index_slides_on_slideshow_id", using: :btree

  create_table "slideshows", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id",         null: false
    t.string   "role_class_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["role_class_name", "user_id"], name: "index_user_roles_on_role_class_name_and_user_id", unique: true, using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: true do |t|
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
