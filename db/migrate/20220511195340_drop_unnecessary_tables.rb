class DropUnnecessaryTables < ActiveRecord::Migration[7.0]
  def change
    remove_column :servers, :ssh_key_id

    drop_table :ssh_keys
    drop_table :stac_events
    drop_table :log_files
  end
end
