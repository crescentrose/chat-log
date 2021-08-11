class ConnectionParserService < ParserService
  ParsedConnectionEvent = Struct.new(
    :connected_at, :ip, :player_name, :player_steamid3, :server_id,
    keyword_init: true
  ) do
    def to_model
      ConnectionEvent.new(self.to_h)
    end
  end

  CONNECTED_REGEX = /^L (?<date>\d{2}\/\d{2}\/\d{4}) - (?<time>\d{2}:\d{2}:\d{2}): "(?<player>.*)<\d+><(?<steamid>\[U:\d:\d+\])><(?<team>\w*)>" connected,\s*address "(?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}):\d*"$/

  def parse_line(line, server)
    return unless match = line.strip.match(CONNECTED_REGEX)
    return if User::TRUSTED_USERS.include? match[:steamid]

    ParsedConnectionEvent.new(
      connected_at: match_to_datetime(match, server.timezone),
      player_name: match[:player],
      player_steamid3: match[:steamid],
      ip: match[:ip],
      server_id: server.id
    )
  end
end
