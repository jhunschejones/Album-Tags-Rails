class CreateAlbumListJoinTable < ActiveRecord::Migration[5.2]
  def up
    create_table :albums_lists, id: false do |t|
      t.integer "album_id", null: false
      t.integer "list_id", null: false
    end
    add_index("albums_lists", ["album_id", "list_id"])
  end

  def down
    drop_table :albums_lists
  end
end
