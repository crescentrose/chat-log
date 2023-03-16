class DropConnectionTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :connection_events, :disconnect_time, :datetime, null: true
  end
end
