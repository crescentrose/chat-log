require 'rails_helper'

RSpec.describe SteamService do
  describe '#resolve_vanity_url' do
    it 'returns a steamid object for given vanity url' do
      VCR.use_cassette('vanity_url') do
        id = subject.resolve_vanity_url('staplestabler')
        expect(id.id64).to eq(76561198054979849)
      end
    end
  end

  describe '#player_summary' do
    it 'returns a single player summary for one steamid' do
      VCR.use_cassette('single_summary') do
        summary = subject.player_summary(76561198054979849)
        expect(summary.name).to eq('VIORA')
      end
    end

    it 'returns multiple summaries for multiple steamids' do
      VCR.use_cassette('multiple_summaries') do
        summary = subject.player_summary([76561198054979849, 'i542'])
        expect(summary.first.name).to eq('VIORA')
        expect(summary.second.name).to eq('Darwin')
      end
    end
  end
end
