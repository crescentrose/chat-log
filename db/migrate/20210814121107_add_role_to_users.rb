class AddRoleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :role, null: true, foreign_key: true

    reversible do |c|
      c.up do
        User.find_each { |user| user.update!(role: Role.everyone) }
      end
    end

    change_column_null :users, :role_id, false
  end
end
