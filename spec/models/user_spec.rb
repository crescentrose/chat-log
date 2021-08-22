# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  avatar_url :string           not null
#  last_login :datetime
#  name       :string           not null
#  steam_id3  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :bigint           not null
#
# Indexes
#
#  index_users_on_role_id    (role_id)
#  index_users_on_steam_id3  (steam_id3)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, role: Role.everyone) }

  it { expect(user.anonymous?).to be false }

  describe '::with_permission' do
    let(:permission) { create :permission }

    it 'returns the users with granted permission' do
      Role.everyone.role_permissions.create(permission: permission)

      expect(User.with_permission(permission.code)).to include(user)
    end

    it 'does not return the user without the granted permission' do
      Role.admin.role_permissions.create(permission: permission)

      expect(User.with_permission(permission.code)).not_to include(user)
    end
  end
end
