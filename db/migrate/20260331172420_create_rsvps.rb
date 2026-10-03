class CreateRsvps < ActiveRecord::Migration[8.1]
  def change
    create_table :rsvps do |t|
      t.references :member, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :rsvps, [ :member_id, :event_id ], unique: true
  end
end
