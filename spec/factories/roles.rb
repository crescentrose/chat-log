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
FactoryBot.define do
  factory :role do
    name { 'new role' }
    color { 'ff0000' }
  end
end
