module LogServer
  class Server
    PORT = ENV.fetch('LOGSERVER_PORT', 27_115)
    BIND_ADDRESS = ENV.fetch('LOGSERVER_BIND', '0.0.0.0')

    def initialize(logger: Rails.logger)
      @logger = logger
    end

    def start(&on_message)
      endpoint = Async::IO::Endpoint.udp(BIND_ADDRESS, PORT)

      logger.info("open port #{PORT} on #{BIND_ADDRESS} for logs")

      Async do |_task|
        endpoint.bind do |socket|
          loop do
            data, origin = socket.recvfrom(2000)
            process(on_message, data, origin)
          end
        end
      end
    ensure
      logger.info('closing log server')
    end

    private

    def process(callback, data, origin)
      Async do |subtask|
        subtask.with_timeout(1) do
          callback.call(data, origin)
        rescue Async::TimeoutError
          logger.error("took too long to process request from #{origin.inspect}")
        end
      end
    end

    attr_reader :logger
  end
end
