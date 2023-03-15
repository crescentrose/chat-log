class AddServerGroupToServers < ActiveRecord::Migration[7.0]
  def change
    add_reference :servers, :server_group, null: true, foreign_key: true
  end
end
