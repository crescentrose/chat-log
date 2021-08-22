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
#  role_id    :bigint           not null
#
# Indexes
#
#  index_users_on_role_id    (role_id)
#  index_users_on_steam_id3  (steam_id3)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord
  include Permissionable

  validates :avatar_url, :name, :steam_id3, presence: true
  validates :steam_id3, uniqueness: true

  belongs_to :role, strict_loading: true

  scope :for_player, ->(identifier) do
    where(steam_id3: SteamId.from(identifier).id3)
  end

  scope :with_permission, ->(permission) do
    joins(role: { role_permissions: :permission }).where(permissions: { code: permission })
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    steamid = SteamId.from(auth_hash.uid)
    default_role = if ENV['OWNER_STEAMID'] && (steamid.id3 == ENV['OWNER_STEAMID'])
                     Role.admin
                   else
                     Role.everyone
                   end
    create_with(
      avatar_url: auth_hash.info.image,
      name: auth_hash.info.nickname,
      role: default_role
    )
      .find_or_create_by(steam_id3: steamid.id3)
  end

  def self.ransackable_scopes(_)
    %i[for_player]
  end

  def anonymous?
    false
  end

  def update_from_steam
    summary = SteamService.new.player_summary(steam_id3)
    assign_attributes(name: summary.name, avatar_url: summary.avatar_url)
  end
end
