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
#  index_messages_on_sent_at          (sent_at)
#  index_messages_on_server_id        (server_id)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
class Message < ApplicationRecord
  has_one :flag
  belongs_to :server

  validates :player_name, :message, :player_steamid3, :player_team, :sent_at,
            presence: true

  after_create :process_word_filter
  after_create_commit :broadcast_create_message

  scope :for_player, lambda { |identifier|
    where(player_steamid3: SteamId.from(identifier).id3)
  }

  scope :flagged, -> { joins(:flag).where(flag: { resolved_at: nil }) }
  scope :resolved, -> { joins(:flag).where.not(flag: { resolved_at: nil }) }
  scope :recent, -> { where(sent_at: 2.weeks.ago..15.minutes.ago) }

  def formatted_sent_at
    sent_at.strftime('%c')
  end

  def flagged?
    flag.present?
  end

  def resolved?
    return true if flag.nil?

    !flag.resolved_at.nil?
  end

  def unresolved?
    flagged? && !resolved?
  end

  def player_steamid64
    @player_steamid64 ||= SteamId.from(player_steamid3).id64
  end

  def process_word_filter
    filter = Swearjar.new(Rails.root + 'config/swears.yml')

    return unless filter.profane?(message)

    create_flag!(
      reason: filter.scorecard(message).keys.join(', '),
    )

    # make sure the record has persisted (rails bullshittery)
    ReportFlaggedMessageJob.set(wait: 5.seconds).perform_later(flag)
  end

  def broadcast_create_message 
    broadcast_prepend_later_to "messages", partial: 'messages/message_frame', target: "messages"
  end

  def self.ransackable_scopes(auth_level)
    if auth_level == :admin
      %i[for_player flagged resolved]
    else
      %i[for_player]
    end
  end

  def self.ransackable_attributes(auth_level)
    %w[message player_name sent_at server_id]
  end

  def self.ransackable_associations(auth_level)
    if auth_level == :admin
      %i[server flag]
    else
      %i[server]
    end
  end
end
