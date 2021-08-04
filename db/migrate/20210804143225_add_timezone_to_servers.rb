class AddTimezoneToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :timezone, :string, default: 'UTC'
  end
end
