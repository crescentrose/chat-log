class AddFlagResolvePermission < ActiveRecord::Migration[6.1]
  def up
    resolve = Permission.create!(
      code: 'flag.resolve',
      name: 'Resolve reports',
      description: 'Members will be able to mark reports as resolved from the web UI.'
    )

    RolePermission.create!(
      role: Role.admin,
      permission: resolve
    )
  end

  def down
    Permission.find_by(code: 'flag.resolve').destroy
  end
end
