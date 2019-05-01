class CreateAlbumConnections < ActiveRecord::Migration[5.2]
  def up
    create_table :album_connections do |t|
      t.integer "user_id", null: false
      t.integer "album_a_id", null: false
      t.integer "album_b_id", null: false
    end
    add_index("album_connections", "user_id")
  end

  def down
    drop_table :album_connections
  end
end
