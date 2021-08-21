class SSHKeysController < ApplicationController
  layout 'admin'
  helper_method :ssh_key

  def index
    authorize SSHKey
    @ssh_keys = SSHKey.includes(:user).order(:name).all
  end

  def new
    authorize SSHKey
    @ssh_key = SSHKey.new
  end

  def create
    @ssh_key = SSHKey.new(ssh_key_params)
    authorize ssh_key

    if ssh_key.save
      flash[:notice] = "Created new SSH key #{ssh_key.name} ✅"
      redirect_to ssh_keys_path
    else
      flash.now[:error] = ssh_key.errors.full_messages
      render :new
    end
  end

  def destroy
    authorize ssh_key

    if ssh_key.destroy
      flash[:notice] = "SSH key #{ssh_key.name} is no more 🗑️"
    else
      flash[:error] = ssh_key.errors.full_messages
    end

    redirect_to ssh_keys_path
  end

  private

  def ssh_key
    @ssh_key ||= SSHKey.find(params[:id])
  end

  def ssh_key_params
    params
      .require(:ssh_key)
      .permit(:name, :private_key)
      .merge(user_id: current_user.id)
  end
end
