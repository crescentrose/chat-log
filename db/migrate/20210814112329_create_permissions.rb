class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :code, null: false

      t.timestamps
    end

    add_index :permissions, :code, unique: true
  end
end
