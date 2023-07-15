class StatsController < ApplicationController
  def index
    render json: REDIS.hgetall("bonca")
  end
end
