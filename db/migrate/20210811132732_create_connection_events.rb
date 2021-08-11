class CreateConnectionEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :connection_events do |t|
      t.string :player_name, null: false
      t.string :player_steamid3, null: false
      t.string :ip, null: false
      t.timestamp :connected_at, null: false
      t.belongs_to :server, null: false

      t.timestamps
    end

    add_index :connection_events, :player_steamid3
    add_index :connection_events, :player_name
    add_index :connection_events, :ip
  end
end
