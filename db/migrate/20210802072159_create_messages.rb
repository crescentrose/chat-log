class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :player_name, null: false
      t.string :player_team, null: false
      t.string :player_steamid3, null: false
      t.boolean :team, null: false, default: false
      t.references :server, null: false, foreign_key: true
      t.text :message, null: false
      t.timestamp :sent_at, null: false

      t.timestamps
    end

    add_index :messages, :player_name
    add_index :messages, :player_steamid3
    add_index :messages, :sent_at, order: { sent_at: :desc }
  end
end
