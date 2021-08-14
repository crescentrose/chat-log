class CreateRolePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :role_permissions do |t|
      t.belongs_to :role, null: false, foreign_key: true
      t.belongs_to :permission, null: false, foreign_key: true

      t.timestamps
    end

    add_index :role_permissions, [:role_id, :permission_id], unique: true
  end
end
