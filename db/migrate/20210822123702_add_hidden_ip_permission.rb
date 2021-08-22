class AddHiddenIpPermission < ActiveRecord::Migration[6.1]
  def up
    hidden_ip = Permission.create!(
      code: 'connections.obscure',
      name: 'Prevent IP Logging',
      description: 'Members will not have their IP addresses saved to the database on connect.'
    )

    RolePermission.create!(
      role: Role.admin,
      permission: hidden_ip
    )
  end

  def down
    Permission.find_by(code: 'connections.obscure').destroy
  end
end
