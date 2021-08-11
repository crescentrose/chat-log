class MessagePolicy < ApplicationPolicy
  def index?
    user.allowed_to?('messages.index')
  end

  def show?
    index?
  end
end
