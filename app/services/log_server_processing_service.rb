class LogServerProcessingService
  def initialize(logger = nil)
    @logger = logger || Rails.logger
    @parsers = [
      MessageParserService.new,
      VotekickParserService.new,
      ConnectionParserService.new(trusted_users),
      DisconnectionParserService.new
    ]

    @servers = Server.all.index_by { |s| [s.ip, s.port] }
  end

  def process(log_line, ip:, port:)
    server = @servers[[ip, port]]

    return if server.nil? # TODO: log

    log_line = sanitize(log_line)

    @parsers.flat_map { |parser| parser.parse_line(log_line, server) if parser.can_parse?(log_line) }
            .compact
            .map(&:to_model)
            .each { |event| event.save!(validate: false) }
  end

  private

  attr_reader :logger

  def sanitize(string)
    string.encode('utf-8', invalid: :replace, undef: :replace)
  end

  def trusted_users
    User.with_permission('connections.obscure').pluck(:steam_id3)
  end
end
