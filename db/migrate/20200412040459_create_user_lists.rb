class CreateUserLists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_lists do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.references :list, null: false, foreign_key: {on_delete: :cascade}
      t.string :role, default: "list_creator"

      t.timestamps
    end

    add_index :user_lists, [:user_id, :list_id], unique: true
  end
end
