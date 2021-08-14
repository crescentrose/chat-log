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
FactoryBot.define do
  factory :permission do
    name { "MyString" }
    description { "MyString" }
    code { "MyString" }
  end
end
