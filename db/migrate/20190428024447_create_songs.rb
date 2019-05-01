class CreateSongs < ActiveRecord::Migration[5.2]
  def up
    create_table :songs do |t|
      t.string "title", null: false
      t.string "length"
      t.integer "album_id", null: false
      t.integer "order", null: false
      t.timestamps
    end
    add_index("songs", "album_id")
  end

  def down
    drop_table :songs
  end
end
