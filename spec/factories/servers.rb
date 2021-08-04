# == Schema Information
#
# Table name: servers
#
#  id          :bigint           not null, primary key
#  last_update :datetime
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :server do
    sequence(:name) { |n| "test-#{n}" }
    timezone { 'UTC' }
  end
end
