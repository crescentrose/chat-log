# == Schema Information
#
# Table name: server_groups
#
#  id         :bigint           not null, primary key
#  icon       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ServerGroup < ApplicationRecord
  has_many :servers

  validates :name, presence: true
  validate :icon_is_emoji

  private
  
  def icon_is_emoji
    errors.add(:icon, 'must be an emoji') unless icon =~ /\p{Emoji}/ or icon.empty?
  end
end
