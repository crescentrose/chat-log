class AddAdministratorRole < ActiveRecord::Migration[6.1]
  def up
    admin = Role.create!(
      name: 'Administrator',
      color: '#DC2626'
    )

    root = Permission.create!(
      code: 'root',
      description: 'This permission allows members to perform ALL actions, including managing all permissions. Use carefully.',
      name: 'Administrator'
    )

    RolePermission.create!(
      role: admin,
      permission: root
    )

    user = Role.create!(
      name: 'Everyone'
    )

    messages = Permission.create!(
      code: 'messages.index',
      description: 'Allows members to view all chat messages from all servers.',
      name: 'View Messages'
    )

    votekicks = Permission.create!(
      code: 'votekicks.index',
      description: 'Allows members to view votekick events',
      name: 'View Votekicks'
    )

    connections = Permission.create!(
      code: 'connections.index',
      description: 'Allows members to look at the connection logs and determine player IPs.',
      name: 'View Player IPs'
    )

    users = Permission.create!(
      code: 'users.index',
      description: 'Allows members to look at everyone who has logged into this web application. (Grant the Administrator permission to allow editing)',
      name: 'View Users'
    )

    RolePermission.create!(
      role: user,
      permission: messages
    )

    RolePermission.create!(
      role: user,
      permission: votekicks
    )
  end

  def down
    RolePermission.delete_all
    Role.delete_all
    Permission.delete_all
  end
end
