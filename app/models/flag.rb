# == Schema Information
#
# Table name: flags
#
#  id                 :bigint           not null, primary key
#  reason             :string           not null
#  resolve_token      :string           not null
#  resolved_at        :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  discord_webhook_id :string
#  message_id         :bigint           not null
#
# Indexes
#
#  index_flags_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
class Flag < ApplicationRecord
  belongs_to :message

  has_secure_token :resolve_token

  def message_text
    message.message
  end

  def message_server
    message.server.friendly_name
  end

  def message_sender_id
    message.player_steamid3
  end

  def message_sent_at
    message.sent_at.strftime('%c')
  end

  def resolve
    update(resolved_at: Time.now)
    ResolveFlaggedMessageJob.perform_later(self)
  end
end
