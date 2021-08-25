class AddActiveToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :is_active, :boolean, default: true, null: false
  end
end
