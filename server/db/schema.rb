# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_01_223937) do

  create_table "locations", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "regex"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["regex"], name: "index_locations_on_regex", unique: true
  end

  create_table "workstation_statuses", force: :cascade do |t|
    t.string "workstation_name"
    t.string "workstation_type"
    t.string "os"
    t.string "user_hash"
    t.string "status"
    t.boolean "guest_flag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workstation_name"], name: "index_workstation_statuses_on_workstation_name", unique: true
  end

end
