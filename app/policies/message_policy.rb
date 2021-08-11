class MessagePolicy < ApplicationPolicy
  def index?
    user.allowed_to?('messages.index')
  end
end
