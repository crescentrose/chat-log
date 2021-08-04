require 'rails_helper'

RSpec.describe MessageParserService do
  let(:server) { create(:server) }
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }

  it 'does not parse non-message logs' do
    parsed_message = subject.parse_line(
      'L 07/30/2021 - 22:09:09: "scuse me miss!<515><[U:1:97746797]><>" entered the game',
      server
    )

    expect(parsed_message).to be_nil
  end
  it 'parses a message log' do
    parsed_message = subject.parse_line(
      'L 07/25/2021 - 14:35:58: "hexerii<361><[U:1:189701717]><Blue>" say "i was standing still at one point bruh come on"',
      server
    )

    expect(parsed_message.message).to eq('i was standing still at one point bruh come on')
    expect(parsed_message.player_name).to eq('hexerii')
    expect(parsed_message.player_steamid3).to eq('[U:1:189701717]')
    expect(parsed_message.player_team).to eq('BLU')
    expect(parsed_message.sent_at).to eq(DateTime.new(2021, 7, 25, 14, 35, 58))
    expect(parsed_message.team).to eq(false)
  end

  it 'parses a team message' do
    parsed_message = subject.parse_line(
      'L 07/25/2021 - 15:34:44: "hexerii<361><[U:1:189701717]><Red>" say_team "play the game instead of complaining 24/7"',
      server
    )
    expect(parsed_message.team).to eq(true)
  end

  it 'is mindful of timezones' do
    parsed_message = subject.parse_line(
      'L 07/25/2021 - 15:34:44: "hexerii<361><[U:1:189701717]><Red>" say_team "play the game instead of complaining 24/7"',
      berlin
    )
    # Berlin is 2 hours ahead of UTC in summer
    expect(parsed_message.sent_at.utc).to eq(Time.utc(2021, 7, 25, 13, 34, 44))
  end

  it 'correctly parses non-English scripts' do
    log = subject.parse_line(
      'L 01/01/1970 - 00:00:00: "ネフェルピトー<0><[U:0:000000]><Red>" say "FUCK İ GONNA GET BOPDY SHOT AGİAMN"',
      server
    )
    expect(log.player_name).to eq('ネフェルピトー')
    expect(log.message).to eq('FUCK İ GONNA GET BOPDY SHOT AGİAMN')
  end
end
