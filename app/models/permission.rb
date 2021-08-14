# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  description :string           not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_permissions_on_code  (code) UNIQUE
#
class Permission < ApplicationRecord
  validates :code, uniqueness: true
  has_many :role_permissions, dependent: :destroy
  has_many :roles, through: :role_permissions
end
