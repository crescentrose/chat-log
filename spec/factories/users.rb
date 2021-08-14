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
FactoryBot.define do
  factory :user do
    name { 'sussy baka' }
    sequence(:steam_id3, 1_000_000) { |n| "[U:0:#{n}]" }
    avatar_url { 'https://placekitten.com/64/64' }
    last_login { Time.now }
    role { Role.everyone }
  end
end
