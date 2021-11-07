class VotekickParserService < ParserService
  ParsedVoteKickEvent = Struct.new(
    :initiator_steamid3, :target_steamid3, :target_name, :time, :server_id,
    keyword_init: true
  ) do
    def to_model
      VotekickEvent.new(to_h)
    end
  end

  VOTEKICK_REGEX = %r{(?<date>\d{2}/\d{2}/\d{4}) - (?<time>\d{2}:\d{2}:\d{2}): Kick Vote details:  VoteInitiatorSteamID: (?<initiator>\[U:\d:\d+\])  VoteTargetSteamID: (?<target>\[U:\d:\d+\])  Valid: 1  BIndividual: 1  Name: (?<name>.*)  Proxy: \d}.freeze

  def can_parse?(line)
    line =~ /Kick Vote details/
  end

  def parse_line(line, server)
    return unless matches = line.strip.match(VOTEKICK_REGEX)
    return if matches[:name] == 'Disconnected' # source spaghetti

    ParsedVoteKickEvent.new(
      initiator_steamid3: matches[:initiator],
      target_steamid3: matches[:target],
      target_name: matches[:name],
      time: match_to_datetime(matches, server.timezone),
      server_id: server.id
    )
  end
end
