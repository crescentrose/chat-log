class UsersController < ApplicationController
  layout 'admin'

  def index
    authorize User

    @q = User
      .includes(:role)
      .ransack(params[:q])

    @users = @q
      .result(distinct: true)
      .order(last_login: :desc)
      .page(params[:page])
      .per(50)
  rescue NotImplementedError => e
    flash[:error] = e.message
    redirect_to users_path
  end

  def update
    if user.update(user_params)
      flash[:notice] = "#{user.name}'s role has been set to #{user.role.name}"
    else
      flash[:error] = user.errors.full_messages
    end

    redirect_to users_path
  end

  private

  def user
    @user ||= User.includes(:role).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role_id)
  end
end
