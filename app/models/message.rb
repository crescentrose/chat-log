# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  flagged_at      :datetime
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
  COMMON_MESSAGES = [
    'gg',
    'ggwp',
    'gg wp',
    'lol',
    'scramble',
    'vscramble',
    '!vscramble',
    'votescramble',
    'nominate',
    '!nominate',
    'rtv',
    '( ͡° ͜ʖ ͡°)',
    '***UBERED***',
    'ok',
    'hi'
  ].freeze

  belongs_to :server, strict_loading: true

  validates :player_name, :message, :player_steamid3, :player_team, :sent_at,
            presence: true

  scope :for_player, ->(identifier) do
    where(player_steamid3: SteamId.from(identifier).id3)
  end

  scope :flagged, ->{ where.not(flagged_at: nil) }
  scope :uncommon, ->{ where.not(message: COMMON_MESSAGES) }

  def self.ransackable_scopes(_)
    %i[for_player flagged]
  end

  def formatted_sent_at
    sent_at.strftime('%c')
  end

  def player_steamid64
    @player_steamid ||= SteamId.from(player_steamid3).id64
  end
end
