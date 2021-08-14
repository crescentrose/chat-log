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
class Role < ApplicationRecord
  validates :name, uniqueness: true

  has_many :role_permissions, dependent: :destroy, strict_loading: true
  has_many :permissions, through: :role_permissions, strict_loading: true
  has_many :users, strict_loading: true

  before_destroy :prevent_if_basic_role
  before_destroy :move_users_to_everyone

  def self.everyone
    Role.find_by(name: 'Everyone')
  end

  def self.admin
    Role.find_by(name: 'Administrator')
  end

  private

  def basic_role?
    ['Administrator', 'Everyone'].include? name
  end

  def prevent_if_basic_role
    return unless basic_role?

    errors.add(:base, 'Basic roles must always be in place.')
    throw(:abort)
  end

  def move_users_to_everyone
    return if basic_role?

    users.update_all(role_id: Role.everyone.id)
  end
end
