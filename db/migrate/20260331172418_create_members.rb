class CreateMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :auth_token
      t.datetime :auth_token_expires_at
      t.boolean :admin, default: false, null: false

      t.timestamps
    end

    add_index :members, :email, unique: true
    add_index :members, :auth_token, unique: true
  end
end
