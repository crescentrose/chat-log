class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    return unless session[:user_id]
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
end
