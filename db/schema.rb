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

ActiveRecord::Schema.define(version: 2021_08_10_215431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "log_files", force: :cascade do |t|
    t.bigint "server_id", null: false
    t.boolean "processed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["server_id"], name: "index_log_files_on_server_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "player_name", null: false
    t.string "player_team", null: false
    t.string "player_steamid3", null: false
    t.boolean "team", default: false, null: false
    t.bigint "server_id", null: false
    t.text "message", null: false
    t.datetime "sent_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_name"], name: "index_messages_on_player_name"
    t.index ["player_steamid3"], name: "index_messages_on_player_steamid3"
    t.index ["server_id"], name: "index_messages_on_server_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "last_update"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "timezone", default: "UTC"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "steam_id3", null: false
    t.string "avatar_url", null: false
    t.datetime "last_login"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["steam_id3"], name: "index_users_on_steam_id3"
  end

  create_table "votekick_events", force: :cascade do |t|
    t.string "initiator_steamid3"
    t.string "target_steamid3"
    t.string "target_name"
    t.datetime "time"
    t.bigint "server_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["initiator_steamid3"], name: "index_votekick_events_on_initiator_steamid3"
    t.index ["server_id"], name: "index_votekick_events_on_server_id"
    t.index ["target_name"], name: "index_votekick_events_on_target_name"
    t.index ["target_steamid3"], name: "index_votekick_events_on_target_steamid3"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "log_files", "servers"
  add_foreign_key "messages", "servers"
  add_foreign_key "votekick_events", "servers"
end
