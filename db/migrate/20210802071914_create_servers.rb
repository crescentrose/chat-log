class CreateServers < ActiveRecord::Migration[6.1]
  def change
    create_table :servers do |t|
      t.string :name
      t.timestamp :last_update

      t.timestamps
    end
  end
end
