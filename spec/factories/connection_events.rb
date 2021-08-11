# == Schema Information
#
# Table name: connection_events
#
#  id              :bigint           not null, primary key
#  connected_at    :datetime         not null
#  ip              :string           not null
#  player_name     :string           not null
#  player_steamid3 :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_connection_events_on_ip               (ip)
#  index_connection_events_on_player_name      (player_name)
#  index_connection_events_on_player_steamid3  (player_steamid3)
#  index_connection_events_on_server_id        (server_id)
#
FactoryBot.define do
  factory :connection_event do
    player_name { "MyString" }
    player_steamid3 { "MyString" }
    ip { "MyString" }
    connected_at { "2021-08-11 15:27:32" }
    server
  end
end
