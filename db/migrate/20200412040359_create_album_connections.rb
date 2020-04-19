class CreateAlbumConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :album_connections do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.integer :parent_album_id, null: false
      t.integer :child_album_id, null: false

      t.timestamps
    end
  end
end
