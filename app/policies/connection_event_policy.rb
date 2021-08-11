class ConnectionEventPolicy < ApplicationPolicy
  def index?
    user.allowed_to?('connections.index')
  end
end
