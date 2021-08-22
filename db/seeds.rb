# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


# Permissions and roles
admin = Role.create!(
  name: 'Administrator',
  color: '#DC2626'
)

user = Role.create!(
  name: 'Everyone'
)

root = Permission.create!(
  code: 'root',
  description: 'This permission allows members to perform ALL actions, including managing all permissions. Use carefully.',
  name: 'Administrator'
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

hidden_ip = Permission.create!(
  code: 'connections.obscure',
  name: 'Prevent IP Logging',
  description: 'Members will not have their IP addresses saved to the database on connect.'
)

RolePermission.create!(
  role: admin,
  permission: servers_index
)

RolePermission.create!(
  role: user,
  permission: messages
)

RolePermission.create!(
  role: user,
  permission: votekicks
)

RolePermission.create!(
  role: admin,
  permission: hidden_ip
)

RolePermission.create!(
  role: admin,
  permission: root
)
