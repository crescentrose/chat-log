class ApplicationController < ActionController::Base
  include Pundit::Authorization

  layout 'main'

  helper_method :current_user, :server_groups

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def current_user
    return AnonymousUser.new unless session[:user_id]
    @current_user ||= User.includes(role: :permissions).find(session[:user_id])
  end

  def current_user=(user)
    if user.nil?
      session[:user_id] = nil
    else
      session[:user_id] = user.id
      current_user
    end
  end

  def user_not_authorized
    flash[:error] = 'You are not allowed to do this.'
    redirect_to '/'
  end

  def not_found
    flash[:error] = 'This record does not exist. (You may have to log in to access it)'
    redirect_to '/'
  end

  def server_groups
    ServerGroup.includes(:servers).where(servers: { is_active: true })
  end
end
