class RolesController < ApplicationController
  layout 'admin'

  helper_method :role, :assignable_permissions

  def index
    authorize Role
    @roles = Role.all.order(:created_at)
  end

  def new
    @role = Role.new
    authorize Role
  end

  def create
    @role = Role.new(role_params)
    authorize role

    if role.save
      flash[:notice] = "Added new role #{role.name} 🎊"
      redirect_to roles_path
    else
      flash.now[:error] = role.errors.full_messages
      render :edit
    end
  end

  def edit
    authorize role
  end

  def update
    authorize role

    if role.update(role_params)
      flash[:notice] = "Updated role #{role.name} ✅"
      redirect_to roles_path
    else
      flash.now[:error] = role.errors.full_messages
      render :edit
    end
  end

  def destroy
    authorize role

    if role.destroy
      flash[:notice] = "Role #{role.name} has been removed and its members moved to the Everyone role."
      redirect_to roles_path
    else
      flash[:error] = role.errors.full_messages
      redirect_to roles_path
    end
  end

  private

  def role
    @role ||= Role.includes(:permissions).find(params[:id])
  end

  def assignable_permissions
    Permission.all
  end

  def role_params
    params.require(:role).permit(:name, :color, permission_ids: [])
  end
end

