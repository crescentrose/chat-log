class FlagsController < ApplicationController
  def resolve
    if (params[:token] == flag.resolve_token || authorize(flag)) && flag.resolved_at.nil?
      flag.resolve
      flash[:notice] = 'Report resolved! Thank you.'
    end

    redirect_back fallback_location: message_path(flag.message)
  end

  def destroy
    authorize flag
    flag.destroy
    redirect_to messages_path
  end

  private

  def flag
    Flag.find(params[:id])
  end
end
