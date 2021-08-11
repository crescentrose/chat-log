# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  message         :text             not null
#  player_name     :string           not null
#  player_steamid3 :string           not null
#  player_team     :string           not null
#  sent_at         :datetime         not null
#  team            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  server_id       :bigint           not null
#
# Indexes
#
#  index_messages_on_player_name      (player_name)
#  index_messages_on_player_steamid3  (player_steamid3)
#  index_messages_on_server_id        (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
class Message < ApplicationRecord
  belongs_to :server, strict_loading: true

  validates :player_name, :message, :player_steamid3, :player_team, :sent_at,
            presence: true

  scope :for_player, ->(identifier) do
    where(player_steamid3: SteamId.from(identifier).id3)
  end

  def self.ransackable_scopes(_)
    %i[for_player]
  end

  def player_steamid64
    @player_steamid ||= SteamId.from(player_steamid3).id64
  end

  def formatted_sent_at
    sent_at.strftime('%c')
  end
end
