require_relative '../log_server'

namespace :log_server do
  desc 'Start the log receiving server'
  task start: :environment do
    logger = Logger.new(STDOUT)
    server = LogServer::Server.new(logger: logger)
    processor = LogServerProcessingService.new
    server.start do |data, origin|
      processor.process(data, ip: origin.ip_address, port: origin.ip_port)
    end
  end
end
