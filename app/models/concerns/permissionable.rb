module Permissionable
  extend ActiveSupport::Concern

  def allowed_to?(permission)
    permissions.include?(permission)
  end
end
