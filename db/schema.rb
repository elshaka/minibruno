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

ActiveRecord::Schema.define(version: 20150428133634) do

  create_table "alarm_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "alarms", force: true do |t|
    t.integer  "alarm_type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alarms", ["alarm_type_id"], name: "index_alarms_on_alarm_type_id", using: :btree
  add_index "alarms", ["created_at"], name: "index_alarms_on_created_at", using: :btree

  create_table "base_units", force: true do |t|
    t.string   "unit"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "motor_stats", force: true do |t|
    t.integer  "motor_id"
    t.boolean  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "motor_stats", ["created_at"], name: "index_motor_stats_on_created_at", using: :btree
  add_index "motor_stats", ["motor_id", "created_at"], name: "index_motor_stats_on_motor_id_and_created_at", using: :btree
  add_index "motor_stats", ["motor_id"], name: "index_motor_stats_on_motor_id", using: :btree

  create_table "motors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "stat_types", force: true do |t|
    t.integer  "base_unit_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "controllable", default: false, null: false
  end

  create_table "stats", force: true do |t|
    t.integer  "stat_type_id"
    t.integer  "user_id"
    t.float    "value",        limit: 24
    t.float    "set_point",    limit: 24
    t.boolean  "auto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stats", ["created_at"], name: "index_stats_on_created_at", using: :btree
  add_index "stats", ["stat_type_id", "created_at"], name: "index_stats_on_stat_type_id_and_created_at", using: :btree
  add_index "stats", ["stat_type_id"], name: "index_stats_on_stat_type_id", using: :btree

  create_table "stops", force: true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turns", force: true do |t|
    t.string   "name"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "fullname",               default: "", null: false
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
    t.integer  "role_id",                default: 2,  null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
