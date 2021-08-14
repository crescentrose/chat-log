class AddServerManagementPermissions < ActiveRecord::Migration[6.1]
  def up
    servers_index = Permission.create!(
      code: 'servers.index',
      name: 'View Servers',
      description: 'Allows members to view the current list of active servers as well as their status.'
    )

    servers_update = Permission.create!(
      code: 'servers.update',
      name: 'Manage Servers',
      description: 'Let members make changes to the server setup, including rcon and ssh keys.'
    )

    RolePermission.create!(
      role: Role.admin,
      permission: servers_index
    )
  end

  def down
    Permission.includes(:roles).where(code: %w[servers.index servers.update]).destroy_all
  end
end
