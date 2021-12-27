class StACParserService < ParserService
  ParsedStACEvent = Struct.new(
    :message, :player_steamid3, :server_id,
    keyword_init: true
  ) do
    def to_model
      StACEvent.new(to_h)
    end
  end

  def can_parse?(line)
    line =~ /StAC/
  end

  def parse_line(line, server)
    return unless (match =~ /StAC/)

    steamid = line.strip.match(/(\[U:\d:\d+\])/)

    # TODO: StAC does not necessarily send things in one neat line (god forbid
    # things are ever easy) so once we're done with Sappho's Bizzare Adventure
    # remember to actually turn this into a coherent model
    # TODO: or just fake this as a discord webhook omegalul
    ParsedStACEvent.new(
        message: line,
        server_id: server.id,
        player_steamid3: steamid&.first
    )
  end
end
