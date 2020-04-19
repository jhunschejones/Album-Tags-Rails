class CreateAlbumTags < ActiveRecord::Migration[6.0]
  def change
    create_table :album_tags do |t|
      t.references :album, null: false, foreign_key: {on_delete: :cascade}
      t.references :tag, null: false, foreign_key: {on_delete: :cascade}
      t.references :user, null: false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end

    add_index :album_tags, [:album_id, :tag_id, :user_id], unique: true
  end
end
