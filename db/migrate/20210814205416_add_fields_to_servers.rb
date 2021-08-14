class AddFieldsToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :friendly_name, :string
    add_column :servers, :ip, :string
    add_column :servers, :port, :integer, default: 27015
    add_column :servers, :rcon_password, :string

    reversible do |dir|
      dir.up do
        Server.update_all(friendly_name: 'changeme', ip: 'example.com', port: 27015)
      end
    end

    change_column_null :servers, :friendly_name, false
    change_column_null :servers, :ip, false
    change_column_null :servers, :port, false
  end
end
