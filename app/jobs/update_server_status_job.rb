class UpdateServerStatusJob < ApplicationJob
  queue_as :default

  def perform
    Server.where.not(rcon_password: [nil, '']).find_each do |server|
      Sidekiq.logger.info "Updating server #{server.name}"
      ServerStatusUpdateService.new.update(server)
    end
  end
end
