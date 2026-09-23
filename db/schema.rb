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

ActiveRecord::Schema[8.1].define(version: 2026_03_31_172420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "address"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "location"
    t.boolean "published", default: false, null: false
    t.string "slug"
    t.datetime "starts_at"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true
    t.index ["starts_at"], name: "index_events_on_starts_at"
  end

  create_table "members", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.string "auth_token"
    t.datetime "auth_token_expires_at"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["auth_token"], name: "index_members_on_auth_token", unique: true
    t.index ["email"], name: "index_members_on_email", unique: true
  end

  create_table "rsvps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "event_id", null: false
    t.bigint "member_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_rsvps_on_event_id"
    t.index ["member_id", "event_id"], name: "index_rsvps_on_member_id_and_event_id", unique: true
    t.index ["member_id"], name: "index_rsvps_on_member_id"
  end

  add_foreign_key "rsvps", "events"
  add_foreign_key "rsvps", "members"
end
