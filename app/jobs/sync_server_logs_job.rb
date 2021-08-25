class SyncServerLogsJob < ApplicationJob
  queue_as :default

  def perform
    Server.active.ssh_enabled.find_each do |server|
      Sidekiq.logger.info "Logs - Updating server #{server.name}"
      LogSyncService.new.sync(server)
    rescue StandardError => e
      Sidekiq.logger.error "Logs - Error updating server #{server.name}:"
      Sidekiq.logger.error e.message
    end
  end
end
