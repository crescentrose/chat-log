require 'rails_helper'

RSpec.describe ConnectionParserService do
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }

  it 'tracks connecting IPs' do
    event = subject.parse_line(
      'L 08/11/2021 - 13:32:27: "VIORA<1><[U:1:0000001]><>" connected, address "127.0.0.1:6969"',
      berlin
    )
    expect(event.ip).to eq('127.0.0.1')
    expect(event.player_steamid3).to eq('[U:1:0000001]')
    expect(event.connected_at).to eq(Time.utc(2021, 8, 11, 11, 32, 27))
  end

  it 'does not track connecting IPs if the user is in trusted list' do
    event = subject.parse_line(
      'L 08/11/2021 - 13:32:27: "VIORA<1><[U:1:94714121]><>" connected, address "127.0.0.1:6969"',
      berlin
    )
    expect(event).to be_nil
  end
end
