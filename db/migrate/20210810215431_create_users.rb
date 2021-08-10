class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :steam_id3, null: false
      t.string :avatar_url, null: false
      t.timestamp :last_login

      t.timestamps
    end

    add_index :users, :steam_id3
  end
end
