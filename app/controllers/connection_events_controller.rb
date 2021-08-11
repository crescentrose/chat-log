class ConnectionEventsController < ApplicationController
  def index
    authorize ConnectionEvent

    @q = ConnectionEvent
      .includes(:server)
      .ransack(params[:q])

    @connection_events = @q
      .result(distinct: true)
      .order(connected_at: :desc)
      .page(params[:page])
      .per(50)
  rescue NotImplementedError => e
    flash[:error] = e.message
    redirect_to votekick_events_path
  end
end
