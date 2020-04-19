class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.boolean :private, default: false
      t.string :permalink

      t.timestamps
    end
  end
end
