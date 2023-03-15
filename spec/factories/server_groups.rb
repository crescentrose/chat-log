# == Schema Information
#
# Table name: server_groups
#
#  id         :bigint           not null, primary key
#  icon       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :server_group do
    name { "Example Group" }
    icon { "🦵" }
  end
end
