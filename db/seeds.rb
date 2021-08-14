# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Current Uncletopia servers
%w[
  lax-1
  sfo-1
  sea-1
  chi-1
  dal-1
  nyc-1
  atl-1
  lon-1
  ber-1
  frk-1
  ham-1
].each do |name|
  Server.create(name: name, last_update: Time.now.utc)
end


# Administrator role and permission
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
