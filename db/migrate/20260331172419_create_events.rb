class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :address
      t.datetime :starts_at
      t.integer :capacity
      t.boolean :published, default: false, null: false
      t.string :slug

      t.timestamps
    end

    add_index :events, :slug, unique: true
    add_index :events, :starts_at
  end
end
