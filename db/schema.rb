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

ActiveRecord::Schema.define(version: 2019_04_28_025611) do

  create_table "album_connections", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "album_a_id", null: false
    t.integer "album_b_id", null: false
    t.index ["user_id"], name: "index_album_connections_on_user_id"
  end

  create_table "albums", force: :cascade do |t|
    t.integer "apple_album_id", null: false
    t.string "apple_url", null: false
    t.string "title", null: false
    t.string "artist", null: false
    t.string "release_date", null: false
    t.string "record_company", null: false
    t.string "cover", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apple_album_id"], name: "index_albums_on_apple_album_id", unique: true
  end

  create_table "albums_lists", id: false, force: :cascade do |t|
    t.integer "album_id", null: false
    t.integer "list_id", null: false
    t.index ["album_id", "list_id"], name: "index_albums_lists_on_album_id_and_list_id"
  end

  create_table "albums_tags", id: false, force: :cascade do |t|
    t.integer "album_id", null: false
    t.integer "tag_id", null: false
    t.index ["album_id", "tag_id"], name: "index_albums_tags_on_album_id_and_tag_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "title", null: false
    t.boolean "private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.string "length"
    t.integer "album_id", null: false
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_songs_on_album_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "text", null: false
    t.string "user_id", null: false
    t.boolean "custom_genre", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "display_name", default: "Unknown User"
    t.string "email", null: false
    t.string "password", null: false
    t.string "profile_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
