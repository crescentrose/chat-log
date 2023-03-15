class CreateServerGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :server_groups do |t|
      t.string :name
      t.string :icon, null: true

      t.timestamps
    end

    up_only { "insert into server_groups(name, icon) values ('Default', '');" }
  end
end
