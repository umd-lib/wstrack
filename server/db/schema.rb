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

ActiveRecord::Schema.define(version: 20160412203104) do

  create_table "current_statuses", force: :cascade do |t|
    t.string   "workstation_name"
    t.string   "status"
    t.string   "os"
    t.string   "user_hash"
    t.boolean  "guest_flag"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "workstation_type"
    t.integer  "location_map_id"
  end

  add_index "current_statuses", ["location_map_id"], name: "index_current_statuses_on_location_map_id"

  create_table "location_maps", force: :cascade do |t|
    t.string   "code"
    t.string   "value"
    t.string   "regex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
