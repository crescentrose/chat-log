# == Schema Information
#
# Table name: role_permissions
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  permission_id :bigint           not null
#  role_id       :bigint           not null
#
# Indexes
#
#  index_role_permissions_on_permission_id              (permission_id)
#  index_role_permissions_on_role_id                    (role_id)
#  index_role_permissions_on_role_id_and_permission_id  (role_id,permission_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (permission_id => permissions.id)
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :role_permission do
    role { nil }
    permission { nil }
  end
end
