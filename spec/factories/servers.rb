# == Schema Information
#
# Table name: servers
#
#  id            :bigint           not null, primary key
#  friendly_name :string           not null
#  ip            :string           not null
#  last_update   :datetime
#  map           :string
#  name          :string           not null
#  players       :integer
#  port          :integer          default(27015), not null
#  rcon_password :string
#  timezone      :string           default("UTC")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :server do
    sequence(:name) { |n| "test-#{n}" }
    timezone { 'UTC' }
    friendly_name { 'Test Server' }
    ip { 'server.example.com' }
    port { 27015 }
  end
end
