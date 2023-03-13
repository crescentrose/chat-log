# == Schema Information
#
# Table name: connection_events
#
#  id              :bigint           not null, primary key
#  connected_at    :datetime         not null
#  disconnect_time :datetime
#  ip              :string           not null
#  player_name     :string           not null
#  player_steamid3 :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_connection_events_on_connected_at     (connected_at)
#  index_connection_events_on_ip               (ip)
#  index_connection_events_on_player_name      (player_name)
#  index_connection_events_on_player_steamid3  (player_steamid3)
#  index_connection_events_on_server_id        (server_id)
#
class ConnectionEvent < ApplicationRecord
  belongs_to :server

  scope :for_player, ->(identifier) do
    where(player_steamid3: SteamId.from(identifier).id3)
  end

  def self.ransackable_scopes(_)
    %i[for_player]
  end

  def player_steamid64
    @player_steamid ||= SteamId.from(player_steamid3).id64
  end

  def self.ransackable_attributes(auth_object = nil)
    ["connected_at", "created_at", "disconnect_time", "id", "ip", "player_name", "player_steamid3", "server_id", "updated_at", "server_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["server"]
  end
end
