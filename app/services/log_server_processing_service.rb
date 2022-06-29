class LogServerProcessingService
  def initialize(logger = nil)
    @logger = logger || Rails.logger
    @parsers = [
      MessageParserService.new,
      VotekickParserService.new,
      ConnectionParserService.new(trusted_users),
      DisconnectionParserService.new,
    ]

    @servers_by_addr = Server.all.index_by { |s| [s.ip, s.port] }
    @servers_by_name = Server.all.index_by(&:name)
  end

  def process(log_line, ip: nil, port: nil, name: nil)
    if name
      server = @servers_by_name[name]
    else
      server = @servers_by_addr[[ip, port]]
      log_line = sanitize(log_line) # TODO: better parsing of extra metadata we receive from rcon logs
    end

    return if server.nil? # TODO: log

    @parsers.flat_map { |parser| parser.parse_line(log_line, server) if parser.can_parse?(log_line) }
            .compact
            .map(&:to_model)
            .each { |event| event.save!(validate: false) }
  end

  private

  attr_reader :logger

  def sanitize(string)
    string[4..].force_encoding(Encoding::UTF_8)
  end

  def trusted_users
    User.with_permission('connections.obscure').pluck(:steam_id3)
  end
end
