class CreateAlbumTagJoinTable < ActiveRecord::Migration[5.2]
  def up
    create_table :albums_tags, id: false do |t|
      t.integer "album_id", null: false
      t.integer "tag_id", null: false
    end
    add_index("albums_tags", ["album_id", "tag_id"])
  end

  def down
    drop_table :albums_tags
  end
end
