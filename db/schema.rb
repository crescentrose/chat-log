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

ActiveRecord::Schema[7.0].define(version: 2023_03_16_122414) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "log_file_status", ["new", "processing", "processed", "error"]

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "connection_events", force: :cascade do |t|
    t.string "player_name", null: false
    t.string "player_steamid3", null: false
    t.string "ip", null: false
    t.datetime "connected_at", precision: nil, null: false
    t.bigint "server_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connected_at"], name: "index_connection_events_on_connected_at"
    t.index ["ip"], name: "index_connection_events_on_ip"
    t.index ["player_name"], name: "index_connection_events_on_player_name"
    t.index ["player_steamid3"], name: "index_connection_events_on_player_steamid3"
    t.index ["server_id"], name: "index_connection_events_on_server_id"
  end

  create_table "disconnection_events", force: :cascade do |t|
    t.datetime "disconnected_at", precision: nil, null: false
    t.string "reason"
    t.string "player_name", null: false
    t.string "player_steamid3", null: false
    t.bigint "server_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disconnected_at"], name: "index_disconnection_events_on_disconnected_at"
    t.index ["player_steamid3"], name: "index_disconnection_events_on_player_steamid3"
    t.index ["server_id"], name: "index_disconnection_events_on_server_id"
  end

  create_table "flags", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.string "reason", null: false
    t.string "resolve_token", null: false
    t.string "discord_webhook_id"
    t.datetime "resolved_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_flags_on_message_id"
  end

  create_table "log_files", force: :cascade do |t|
    t.bigint "server_id", null: false
    t.string "map_name", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", default: "new", null: false, enum_type: "log_file_status"
    t.index ["server_id"], name: "index_log_files_on_server_id"
    t.index ["status"], name: "index_log_files_on_status"
  end

  create_table "messages", force: :cascade do |t|
    t.string "player_name", null: false
    t.string "player_team", null: false
    t.string "player_steamid3", null: false
    t.boolean "team", default: false, null: false
    t.bigint "server_id", null: false
    t.text "message", null: false
    t.datetime "sent_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_name"], name: "index_messages_on_player_name"
    t.index ["player_steamid3"], name: "index_messages_on_player_steamid3"
    t.index ["sent_at"], name: "index_messages_on_sent_at", order: :desc
    t.index ["server_id"], name: "index_messages_on_server_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_permissions_on_code", unique: true
  end

  create_table "role_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id", "permission_id"], name: "index_role_permissions_on_role_id_and_permission_id", unique: true
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", default: "#6B7280", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "server_groups", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "last_update", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone", default: "UTC"
    t.string "friendly_name", null: false
    t.string "ip", null: false
    t.integer "port", default: 27015, null: false
    t.string "rcon_password"
    t.string "map"
    t.integer "players"
    t.datetime "last_log_sync", precision: nil
    t.string "last_uploaded_file"
    t.boolean "is_active", default: true, null: false
    t.string "upload_token"
    t.bigint "server_group_id"
    t.index ["server_group_id"], name: "index_servers_on_server_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "steam_id3", null: false
    t.string "avatar_url", null: false
    t.datetime "last_login", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["steam_id3"], name: "index_users_on_steam_id3"
  end

  create_table "votekick_events", force: :cascade do |t|
    t.string "initiator_steamid3"
    t.string "target_steamid3"
    t.string "target_name"
    t.datetime "time", precision: nil
    t.bigint "server_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initiator_steamid3"], name: "index_votekick_events_on_initiator_steamid3"
    t.index ["server_id"], name: "index_votekick_events_on_server_id"
    t.index ["target_name"], name: "index_votekick_events_on_target_name"
    t.index ["target_steamid3"], name: "index_votekick_events_on_target_steamid3"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "disconnection_events", "servers"
  add_foreign_key "flags", "messages"
  add_foreign_key "log_files", "servers"
  add_foreign_key "messages", "servers"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "servers", "server_groups"
  add_foreign_key "users", "roles"
  add_foreign_key "votekick_events", "servers"
end
