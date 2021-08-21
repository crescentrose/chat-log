class ServersController < ApplicationController
  helper_method :server

  def index
    authorize Server
    @servers = Server.order(:name).all
  end

  def admin
    authorize Server
    @servers = Server.order(:name).all
    render :admin, layout: 'admin'
  end

  def new
    authorize Server
    @server = Server.new
    render :new, layout: 'admin'
  end

  def create
    @server = Server.new(server_params)
    authorize server

    if server.save
      flash[:notice] = "Created new server #{server.name} ✅"
      redirect_to admin_servers_path
    else
      flash.now[:error] = server.errors.full_messages
      render :edit, layout: 'admin'
    end
  end

  def update
    authorize server

    if server.update(server_params)
      flash[:notice] = "Updated server #{server.name} ✅"
      redirect_to admin_servers_path
    else
      flash.now[:error] = server.errors.full_messages
      render :edit, layout: 'admin'
    end
  end

  def edit
    authorize server
    render :edit, layout: 'admin'
  end

  def destroy
    authorize server

    if server.destroy
      flash[:notice] = "Server #{server.name} is no more 🗑️"
    else
      flash[:error] = server.errors.full_messages
    end

    redirect_to admin_servers_path
  end

  private

  def server
    @server ||= Server.find(params[:id])
  end

  def server_params
    params
      .require(:server)
      .permit(:friendly_name, :ip, :name, :port, :rcon_password, :timezone, :ssh_key_id)
  end
end
