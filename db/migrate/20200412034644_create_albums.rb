class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :apple_album_id, null: false
      t.string :apple_url, null: false
      t.string :title, null: false
      t.string :artist, null: false
      t.string :release_date, null: false
      t.string :record_company, null: false
      t.string :cover, null: false
      t.jsonb :songs

      t.timestamps
    end
  end
end
