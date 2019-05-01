class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.string "display_name", default: "Unknown User"
      t.string "email", null: false
      t.string "password", null: false
      t.string "profile_image"
      t.timestamps
    end
    add_index("users", "email", unique: true)
  end

  def down 
    drop_table :users
  end
end
