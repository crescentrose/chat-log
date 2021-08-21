class UpdateServerStatusJob < ApplicationJob
  queue_as :default

  def perform
    Server.where.not(rcon_password: [nil, '']).find_each do |server|
      Sidekiq.logger.info "Updating server #{server.name}"
      ServerStatusUpdateService.new.update(server)
    rescue StandardError => e
      Sidekiq.logger.error "Error updating server #{server.name}:"
      Sidekiq.logger.error e.message
    end
  end
end
