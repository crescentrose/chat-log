class ServerGroupsController < ApplicationController
  layout 'admin'

  def index
    authorize ServerGroup

    @server_groups = ServerGroup.all
      .order(name: :asc)
      .page(params[:page])
      .per(50)
  end

  def create
    server_group = ServerGroup.new(
      server_group_params
    )

    authorize server_group

    if server_group.save
      flash[:notice] = "#{server_group.name} has been added."
    else
      flash[:error] = server_group.errors.full_messages
    end

    redirect_to server_groups_path
  end

  def update
    authorize server_group

    if server_group.update(server_group_params)
      flash[:notice] = "#{server_group.name} has been updated."
    else
      flash[:error] = server_group.errors.full_messages
    end

    redirect_to server_groups_path
  end

  def destroy
    authorize server_group

    if server_group.destroy
      flash[:notice] = "#{server_group.name} has been deleted."
    else
      flash[:error] = server_group.errors.full_messages
    end

    redirect_to server_groups_path
  end

  private

  def server_group
    @server_group ||= ServerGroup.find(params[:id])
  end

  def server_group_params
    params.require(:server_group).permit(:name, :icon)
  end
end
