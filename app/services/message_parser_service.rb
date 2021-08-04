class MessageParserService
  ParsedMessage = Struct.new(
    :message, :player_name, :player_steamid3, :player_team, :sent_at, :team,
    :server_id, keyword_init: true
  ) do
    def to_model
      Message.new(self.to_h)
    end
  end

  MESSAGE_REGEX = /
    ^L\                              # Each log line starts with a letter L
                                     # followed by a space.
    (?<date>\d{2}\/\d{2}\/\d{4})\    # This will match the date (mm-dd-yyyy)
    -\ (?<time>\d{2}:\d{2}:\d{2}):\  # Then we match the time (hh:mm:ss).
    "(?<player>.*)<\d+>              # Match player name and skip over their
                                     # ingame ID (we do not need it yet)
    <(?<steamid>\[U:\d:\d+\])>       # Get their SteamID3 ([U:1:12345678])
    <(?<team>Blue|Red)>"\            # Match their team to either Blu or Red
    say(?<tc>_team)?\                 # Team chat messages are a bit different.
    "(?<message>.*)"$                # Match their actual message
  /x

  def parse_line(line, server)
    return unless matches = line.strip.match(MESSAGE_REGEX)

    ParsedMessage.new(
      message: matches[:message],
      player_name: matches[:player],
      player_steamid3: matches[:steamid],
      player_team: player_team(matches[:team]),
      sent_at: match_to_datetime(matches, server.timezone),
      team: !matches[:tc].nil?,
      server_id: server.id
    )
  end

  private

  def player_team(name)
    case name
    when 'Blue'
      'BLU'
    when 'Red'
      'RED'
    else
      'SPEC'
    end
  end

  def match_to_datetime(matches, timezone)
    Time.zone = timezone
    Time.zone.strptime("#{matches[:date]} #{matches[:time]}", '%m/%d/%Y %T')
  end
end
