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
  validates :avatar_url, :name, :steam_id3, presence: true
  validates :steam_id3, uniqueness: true

  def self.find_or_create_from_auth_hash(auth_hash)
    steamid = SteamId.from(auth_hash.uid)
    create_with(avatar_url: auth_hash.info.image, name: auth_hash.info.nickname)
      .find_or_create_by(steam_id3: steamid.id3)
  end
end
