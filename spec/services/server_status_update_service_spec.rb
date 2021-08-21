require 'rails_helper'

RSpec.describe ServerStatusUpdateService do
  let(:server) { create :server, rcon_password: '111111' }
  let(:mock_client) do
    Class.new do
      Response = Struct.new(:body)
      def authenticate!; end
      def end_session!; end
      def execute(cmd)
        Response.new(<<~STATUS)
          hostname: Uncletopia | Los Angeles
          version : 6623512/24 6623512 secure
          udp/ip  : 0.0.0.0:27015  (public ip: 64.94.100.214)
          steamid : [G:1:3333656] (85568392923373080)
          account : not logged in  (No account specified)
          map     : pl_frontier_final at: 0 x, 0 y, 0 z
          tags    : Uncletopia,nocrits,nodmgspread,payload
          players : 1 humans, 0 bots (32 max)
          edicts  : 1108 used of 2048 max
          # userid name                uniqueid            connected ping loss state  adr
          #     17 "Malloy! (^)"       [U:1:12345678]    02:12       45    0 active 0.0.0.0:27005
        STATUS
      end
    end
  end

  it 'parses the status' do
    allow(Rcon::Client).to receive(:new).and_return(mock_client.new)

    ServerStatusUpdateService.new.update(server)

    expect(server.map).to eq('pl_frontier_final')
    expect(server.players).to eq(1)
  end
end
