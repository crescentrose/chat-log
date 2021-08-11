require 'rails_helper'

RSpec.describe DisconnectionParserService do
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }

  it 'tracks disconnecting IPs' do
    event = subject.parse_line(
      'L 08/11/2021 - 16:51:36: "hexerii<275><[U:1:0000001]><Blue>" disconnected (reason "Disconnect by user.")',
      berlin
    )
    expect(event.player_steamid3).to eq('[U:1:0000001]')
    expect(event.disconnected_at).to eq(Time.utc(2021, 8, 11, 14, 51, 36))
    expect(event.reason).to eq('Disconnect by user.')
  end
end
