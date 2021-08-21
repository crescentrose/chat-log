class AddServerStatusToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :map, :string
    add_column :servers, :players, :integer
  end
end
