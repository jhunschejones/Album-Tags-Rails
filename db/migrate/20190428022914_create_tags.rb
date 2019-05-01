class CreateTags < ActiveRecord::Migration[5.2]
  def up
    create_table :tags do |t|
      t.string "text", null: false
      t.string "user_id", null: false
      t.boolean "custom_genre", default: false
      t.timestamps
    end
    add_index("tags", "user_id")
  end

  def down
    drop_table :tags
  end
end
