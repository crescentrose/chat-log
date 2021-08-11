class ApplicationController < ActionController::Base
  include Pundit

  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    return AnonymousUser.new unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def current_user=(user)
    if user.nil?
      session[:user_id] = nil
    else
      session[:user_id] = user.id
      @current_user = User.find(session[:user_id])
    end
  end

  def user_not_authorized
    flash[:error] = 'You are not allowed to do this.'
    redirect_to '/'
  end
end
