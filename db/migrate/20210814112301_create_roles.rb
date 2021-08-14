class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.string :color, null: false, default: '#6B7280'

      t.timestamps
    end

    add_index :roles, :name, unique: true
  end
end
