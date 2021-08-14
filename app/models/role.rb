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
  validate :basic_role_names_are_read_only, on: :update

  has_many :role_permissions, dependent: :destroy
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
    basic_role_names = %w[Administrator Everyone]
    to_check = name_was.nil? ? name : name_was
    ['Administrator', 'Everyone'].include? to_check
  end

  def prevent_if_basic_role
    return unless basic_role?

    errors.add(:base, 'Basic roles must always be in place.')
    throw(:abort)
  end

  def basic_role_names_are_read_only
    return unless basic_role?

    errors.add(:name, 'must not be changed for core roles') if name_changed?
  end

  def move_users_to_everyone
    return if basic_role?

    users.update_all(role_id: Role.everyone.id)
  end
end
