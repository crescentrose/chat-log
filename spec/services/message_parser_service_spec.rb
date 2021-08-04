require 'rails_helper'

RSpec.describe MessageParserService do
  let(:sample_log) do
    <<~LOG
      L 07/30/2021 - 22:09:09: "scuse me miss!<515><[U:1:97746797]><unknown>" spawned as "undefined"
      L 07/30/2021 - 22:09:09: "scuse me miss!<515><[U:1:97746797]><>" entered the game
      L 07/25/2021 - 14:35:58: "hexerii<361><[U:1:189701717]><Blue>" say "i was standing still at one point bruh come on"
      L 07/25/2021 - 15:34:44: "hexerii<361><[U:1:189701717]><Red>" say_team "play the game instead of complaining 24/7"
    LOG
  end

  it 'parses a message log' do
    parsed_messages = subject.parse(sample_log)
    expect(parsed_messages.first.message).to eq('i was standing still at one point bruh come on')
    expect(parsed_messages.first.player_name).to eq('hexerii')
    expect(parsed_messages.first.player_steamid3).to eq('[U:1:189701717]')
    expect(parsed_messages.first.player_team).to eq('BLU')
    expect(parsed_messages.first.sent_at).to eq(DateTime.new(2021, 7, 25, 14, 35, 58))
    expect(parsed_messages.first.team).to eq(false)
    expect(parsed_messages.second.team).to eq(true)
  end

  it 'is mindful of timezones' do
    parsed_messages = subject.parse(<<~LOG, 'Europe/Berlin')
      L 07/25/2021 - 15:34:44: "hexerii<361><[U:1:189701717]><Red>" say_team "play the game instead of complaining 24/7"
    LOG
    # Berlin is 2 hours ahead of UTC in summer
    expect(parsed_messages.first.sent_at.utc).to eq(Time.utc(2021, 7, 25, 13, 34, 44))
  end

  it 'ensures cheeky little buggers do not fuck encoding up' do
    log = subject.parse(
      <<~LOG
        L 01/01/1970 - 00:00:00: "foo<0><[U:0:000000]><Red>" say "I am naughty \xD1"
      LOG
    ) 
    expect(log.first.message).to eq('I am naughty �')
  end

  it 'correctly parses non-English scripts' do
    log = subject.parse(
      <<~LOG
        L 01/01/1970 - 00:00:00: "ネフェルピトー<0><[U:0:000000]><Red>" say "FUCK İ GONNA GET BOPDY SHOT AGİAMN"
      LOG
    ) 
    expect(log.first.player_name).to eq('ネフェルピトー')
    expect(log.first.message).to eq('FUCK İ GONNA GET BOPDY SHOT AGİAMN')
  end
end
