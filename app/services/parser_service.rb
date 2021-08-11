class ParserService
  def parse_line
    raise NotImplementedError, 'override this or #parse to parse logs'
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
