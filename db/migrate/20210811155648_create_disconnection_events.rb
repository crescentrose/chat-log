class CreateDisconnectionEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :disconnection_events do |t|
      t.timestamp :disconnected_at, null: false
      t.string :reason
      t.string :player_name, null: false
      t.string :player_steamid3, null: false
      t.belongs_to :server, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :disconnection_events, :player_steamid3
  end
end
