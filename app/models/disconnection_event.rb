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
#  index_disconnection_events_on_disconnected_at  (disconnected_at)
#  index_disconnection_events_on_player_steamid3  (player_steamid3)
#  index_disconnection_events_on_server_id        (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
class DisconnectionEvent < ApplicationRecord
  belongs_to :server
  
  after_create :update_matching_connection_event

  def update_matching_connection_event
    event = ConnectionEvent.where(player_steamid3: player_steamid3, server_id: server_id).order(connected_at: :desc).take

    return if event.nil? || event.disconnect_time.present? || event.connected_at > 18.hours.ago

    event.update(disconnect_time: disconnected_at)
  end
end
