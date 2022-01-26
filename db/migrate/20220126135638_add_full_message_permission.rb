class AddFullMessagePermission < ActiveRecord::Migration[6.1]
  def up
    full_message = Permission.create!(
      code: 'messages.full_index',
      name: 'View All Messages',
      description: 'View messages beyond the standard 2 week interval.'
    )

    RolePermission.create!(
      role: Role.admin,
      permission: full_message
    )
  end

  def down
    Permission.find_by(code: 'message.full_index').destroy
  end
end
