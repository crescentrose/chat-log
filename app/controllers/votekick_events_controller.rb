class VotekickEventsController < ApplicationController
  def index
    @q = VotekickEvent
      .includes(:server)
      .ransack(params[:q])

    @votekick_events = @q
      .result(distinct: true)
      .order(time: :desc)
      .page(params[:page])
      .per(50)
  end
end
