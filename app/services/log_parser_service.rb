class LogParserService
  ParsedMessage = Struct.new(:message, :player_name, :player_steamid3,
                             :player_team, :sent_at, :team, keyword_init: true)
  
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

  def parse(messages)
    messages.lines.map { |line| parse_line(sanitize(line)) }.compact
  end

  def parse_blob(blob)
    blob.open do |tempfile|
      parse(tempfile.read.bytes.pack("c*").force_encoding('utf-8'))
    end
  end

  private

  def parse_line(line)
    return unless matches = line.strip.match(MESSAGE_REGEX)

    ParsedMessage.new(
      message: matches[:message],
      player_name: matches[:player],
      player_steamid3: matches[:steamid],
      player_team: player_team(matches[:team]),
      sent_at: DateTime.strptime("#{matches[:date]} #{matches[:time]}", '%m/%d/%Y %T'),
      team: !matches[:tc].nil?
    )
  end

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

  def sanitize(string)
    string.encode('utf-8', invalid: :replace, undef: :replace)
  end
end
