require 'rails_helper'

RSpec.describe VotekickParserService do
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }

  it 'parses a valid kick log' do
    parsed_message = subject.parse_line(
      'L 08/01/2021 - 16:49:29: Kick Vote details:  VoteInitiatorSteamID: [U:1:0000001]  VoteTargetSteamID: [U:1:0000002]  Valid: 1  BIndividual: 1  Name: Убийца димы  Proxy: 0',
      berlin
    )

    expect(parsed_message.initiator_steamid3).to eq('[U:1:0000001]')
    expect(parsed_message.target_steamid3).to eq('[U:1:0000002]')
    expect(parsed_message.target_name).to eq('Убийца димы')
    expect(parsed_message.time.utc).to eq(Time.utc(2021, 8, 1, 14, 49, 29))
  end

  it 'skips over source spaghetti logs' do
    parsed_message = subject.parse_line(
      'L 08/01/2021 - 10:43:12: Kick Vote details:  VoteInitiatorSteamID: [U:1:0000001]  VoteTargetSteamID: [U:1:0000002]  Valid: 1  BIndividual: 1  Name: Disconnected  Proxy: 0',
      berlin
    )

    expect(parsed_message).to be_nil
  end
end
