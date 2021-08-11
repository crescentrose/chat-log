class VotekickEventsController < ApplicationController
  def index
    authorize VotekickEvent

    @q = VotekickEvent
      .includes(:server)
      .ransack(params[:q])

    @votekick_events = @q
      .result(distinct: true)
      .order(time: :desc)
      .page(params[:page])
      .per(50)
  rescue NotImplementedError => e
    flash[:error] = e.message
    redirect_to votekick_events_path
  end
end
