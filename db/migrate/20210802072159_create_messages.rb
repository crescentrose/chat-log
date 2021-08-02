class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :player_name
      t.string :player_team
      t.string :player_steamid3
      t.boolean :team
      t.references :server, null: false, foreign_key: true
      t.text :message
      t.timestamp :sent_at

      t.timestamps
    end
  end
end
