class AddDisconnectTimeToConnectionEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :connection_events, :disconnect_time, :timestamp
    add_index :connection_events, :connected_at
    add_index :disconnection_events, :disconnected_at
  end
end
