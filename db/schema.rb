# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_12_042514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_connections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "parent_album_id", null: false
    t.integer "child_album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_album_connections_on_user_id"
  end

  create_table "album_lists", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id", "list_id"], name: "index_album_lists_on_album_id_and_list_id", unique: true
    t.index ["album_id"], name: "index_album_lists_on_album_id"
    t.index ["list_id"], name: "index_album_lists_on_list_id"
  end

  create_table "album_tags", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "tag_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id", "tag_id", "user_id"], name: "index_album_tags_on_album_id_and_tag_id_and_user_id", unique: true
    t.index ["album_id"], name: "index_album_tags_on_album_id"
    t.index ["tag_id"], name: "index_album_tags_on_tag_id"
    t.index ["user_id"], name: "index_album_tags_on_user_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string "apple_album_id", null: false
    t.string "apple_url", null: false
    t.string "title", null: false
    t.string "artist", null: false
    t.string "release_date", null: false
    t.string "record_company", null: false
    t.string "cover", null: false
    t.string "songs", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "private", default: false
    t.string "permalink"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "text", null: false
    t.boolean "custom_genre", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.string "role", default: "list_creator"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["list_id"], name: "index_user_lists_on_list_id"
    t.index ["user_id", "list_id"], name: "index_user_lists_on_user_id_and_list_id", unique: true
    t.index ["user_id"], name: "index_user_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name_ciphertext", null: false
    t.string "name_bidx", null: false
    t.string "email_ciphertext", null: false
    t.string "email_bidx", null: false
    t.string "site_role", default: "site_user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email_bidx"], name: "index_users_on_email_bidx", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "album_connections", "users", on_delete: :cascade
  add_foreign_key "album_lists", "albums", on_delete: :cascade
  add_foreign_key "album_lists", "lists", on_delete: :cascade
  add_foreign_key "album_tags", "albums", on_delete: :cascade
  add_foreign_key "album_tags", "tags", on_delete: :cascade
  add_foreign_key "album_tags", "users", on_delete: :cascade
  add_foreign_key "user_lists", "lists", on_delete: :cascade
  add_foreign_key "user_lists", "users", on_delete: :cascade
end
