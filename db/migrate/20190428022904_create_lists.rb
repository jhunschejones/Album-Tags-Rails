class CreateLists < ActiveRecord::Migration[5.2]
  def up
    create_table :lists do |t|
      t.string "user_id", null: false
      t.string "title", null: false
      t.boolean "private", default: false
      t.timestamps
    end
    add_index("lists", "user_id")
  end

  def down
    drop_table :lists
  end
end
