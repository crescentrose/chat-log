module Permissionable
  extend ActiveSupport::Concern

  def allowed_to?(permission)
    permissions.include?(permission) || root?
  end

  def permissions
    @permissions ||= role.permissions.pluck(:code)
  end

  def owner?
    return false if ENV['OWNER_STEAMID'].nil?

    steam_id3 == ENV['OWNER_STEAMID']
  end

  def root?
    permissions.include?('root') || owner?
  end

  def policy(resource)
    Pundit::PolicyFinder.new(resource).policy.new(self, resource)
  end
end
