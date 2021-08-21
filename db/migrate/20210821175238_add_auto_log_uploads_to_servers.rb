class AddAutoLogUploadsToServers < ActiveRecord::Migration[6.1]
  def change
    add_reference :servers, :ssh_key, null: true, foreign_key: true
    add_column :servers, :last_log_sync, :timestamp
    add_column :servers, :last_uploaded_file, :string

    reversible do |dir|
      dir.up { Server.update_all('last_log_sync = last_update') }
    end
  end
end
