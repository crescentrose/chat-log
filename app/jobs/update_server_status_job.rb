class UpdateServerStatusJob < ApplicationJob
  queue_as :default

  def perform
    Server.active.rcon_enabled.find_each do |server|
      Sidekiq.logger.info "RCON - Updating server #{server.name}"
      ServerStatusUpdateService.new.update(server)
    rescue StandardError => e
      Sidekiq.logger.error "RCON - Error updating server #{server.name}:"
      Sidekiq.logger.error e.message
    end
  end
end
