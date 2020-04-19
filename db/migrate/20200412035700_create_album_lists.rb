class CreateAlbumLists < ActiveRecord::Migration[6.0]
  def change
    create_table :album_lists do |t|
      t.references :album, null: false, foreign_key: {on_delete: :cascade}
      t.references :list, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end

    add_index :album_lists, [:album_id, :list_id], unique: true
  end
end
