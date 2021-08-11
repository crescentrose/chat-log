# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  avatar_url :string           not null
#  last_login :datetime
#  name       :string           not null
#  steam_id3  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_steam_id3  (steam_id3)
#
class User < ApplicationRecord
  include Permissionable

  DEFAULT_PERMISSIONS = %w[
    messages.index
    votekicks.index
  ].freeze

  # TODO: Replace this with actual permissions system
  TRUSTED_USERS = [
    '[U:1:74792263]', # Awan
    '[U:1:10403381]', # b4nny
    '[U:1:32604711]', # camp3r
    '[U:1:81806034]', # Chloemew
    '[U:1:11275974]', # digitaldisorder
    '[U:1:221123406]', # JONTTM
    '[U:1:83786318]', # Kaiga
    '[U:1:43645661]', # pazer
    '[U:1:82329518]', # rf
    '[U:1:86575668]', # Rokki
    '[U:1:123868297]', # roto
    '[U:1:1014255]', # SQU1RRELLY
    '[U:1:97733808]', # Uncle Dane
    '[U:1:94714121]', # VIORA
  ]

  validates :avatar_url, :name, :steam_id3, presence: true
  validates :steam_id3, uniqueness: true

  def self.find_or_create_from_auth_hash(auth_hash)
    steamid = SteamId.from(auth_hash.uid)
    create_with(avatar_url: auth_hash.info.image, name: auth_hash.info.nickname)
      .find_or_create_by(steam_id3: steamid.id3)
  end

  def anonymous?
    false
  end

  def permissions
    if TRUSTED_USERS.include? steam_id3
      DEFAULT_PERMISSIONS + ['connections.index']
    else
      DEFAULT_PERMISSIONS
    end
  end
end
