# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  color      :string           default("#6B7280"), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:admin) { Role.includes(:permissions).find_by(name: 'Administrator') }
  let(:everyone) { Role.includes(:permissions).find_by(name: 'Everyone') }

  it 'prevents the basic roles from being deleted' do
    expect(admin.destroy).to be false
    expect(everyone.destroy).to be false
  end

  it 'prevents the basic roles from being renamed' do
    expect(admin.update(name: 'foo')).to be false
    expect(everyone.update(name: 'foo')).to be false
  end

  it 'allows other roles to be renamed' do
    role = create(:role)
    expect(role.update(name: 'new role (2)')).to be true
  end

  it 'moves users to the Everyone role on deletion' do
    role = create(:role)
    user = create(:user, role: role)

    role.destroy!
    user = User.includes(:role).find(user.id) # can't do #reload due to strict loading...

    expect(user.role).to eq(everyone)
  end
end
