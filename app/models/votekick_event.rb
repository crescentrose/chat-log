# == Schema Information
#
# Table name: votekick_events
#
#  id                 :bigint           not null, primary key
#  initiator_steamid3 :string
#  target_name        :string
#  target_steamid3    :string
#  time               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  server_id          :bigint           not null
#
# Indexes
#
#  index_votekick_events_on_initiator_steamid3  (initiator_steamid3)
#  index_votekick_events_on_server_id           (server_id)
#  index_votekick_events_on_target_name         (target_name)
#  index_votekick_events_on_target_steamid3     (target_steamid3)
#
# Foreign Keys
#
#  fk_rails_...  (server_id => servers.id)
#
class VotekickEvent < ApplicationRecord
  belongs_to :server

  scope :for_initiator, ->(identifier) do
    where(initiator_steamid3: SteamId.from(identifier).id3)
  end

  scope :for_target, ->(identifier) do
    where(target_steamid3: SteamId.from(identifier).id3)
  end

  def self.ransackable_scopes(_)
    %i[for_initiator for_target]
  end

  def initiator_steamid64
    @initiator_steamid64 ||= SteamId.from(initiator_steamid3).id64
  end

  def target_steamid64
    @target_steamid64 ||= SteamId.from(target_steamid3).id64
  end

  def self.ransackable_attributes(_)
    %w[time server_id target_name server_id]
  end

  def self.ransackable_associations(_)
    %w["server"]
  end
end
