class ServersController < ApplicationController
  helper_method :server

  def index
    authorize Server
    @servers = Server.active.order(:friendly_name)
  end

  def admin
    authorize Server
    @servers = Server.order(:friendly_name).all
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
      .permit(:friendly_name, :ip, :name, :port, :rcon_password, :timezone, :is_active)
  end
end
