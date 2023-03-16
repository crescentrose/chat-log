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

  def player_steamid64
    @player_steamid ||= SteamId.from(player_steamid3).id64
  end

  def self.ransackable_scopes(auth_level)
    %i[for_player] if auth_level == :admin
  end

  def self.ransackable_attributes(auth_level = nil)
    ["connected_at", "ip", "player_name", "player_steamid3", "server_id"] if auth_level == :admin
  end

  def self.ransackable_associations(auth_level = nil)
    ["server"] if auth_level == :admin
  end
end
