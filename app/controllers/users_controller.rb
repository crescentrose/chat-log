class UsersController < ApplicationController
  def index
    authorize User
    @users = User.all
  end
end
