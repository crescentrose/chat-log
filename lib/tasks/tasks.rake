require_relative '../progress_bar'

namespace :tasks do
  desc 'Recalculate play times from connect and disconnect events'
  task recalculate_play_times: :environment do
    progress = ProgressBar.new(ConnectionEvent.count)

    ConnectionEvent.where(player_steamid3: '[U:1:60526645]').find_each do |connect|
      matching_disconnect = DisconnectionEvent.where(player_steamid3: connect.player_steamid3, server_id: connect.server_id, disconnected_at: connect.connected_at..)
                                              .order(disconnected_at: :asc).take

      next if matching_disconnect.nil? || matching_disconnect.disconnected_at > (connect.connected_at + 18.hours)

      connect.update(disconnect_time: matching_disconnect.disconnected_at)

      progress.increment
    end
  end
end
