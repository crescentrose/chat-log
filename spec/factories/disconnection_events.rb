# == Schema Information
#
# Table name: disconnection_events
#
#  id              :bigint           not null, primary key
#  disconnected_at :datetime         not null
#  player_name     :string           not null
#  player_steamid3 :string           not null
#  reason          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_disconnection_events_on_player_steamid3  (player_steamid3)
#  index_disconnection_events_on_server_id        (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
FactoryBot.define do
  factory :disconnection_event do
    disconnected_at { "2021-08-11 17:56:48" }
    reason { "MyString" }
    player_name { "MyString" }
    player_steamid3 { "MyString" }
    server { nil }
  end
end
