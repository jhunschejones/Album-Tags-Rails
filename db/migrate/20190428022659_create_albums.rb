class CreateAlbums < ActiveRecord::Migration[5.2]
  def up
    create_table :albums do |t|
      t.integer "apple_album_id", null: false
      t.string "apple_url", null: false
      t.string "title", null: false
      t.string "artist", null: false
      t.string "release_date", null: false
      t.string "record_company", null: false
      t.string "cover", null: false
      t.timestamps
    end
    add_index("albums", "apple_album_id", unique: true)
  end

  def down
    drop_table :albums
  end
end
