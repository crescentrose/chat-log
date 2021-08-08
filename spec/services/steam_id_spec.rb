require 'rails_helper'

RSpec.describe SteamId do
  context 'with part = 1' do
    let(:steam_id) { 'STEAM_0:1:47357060' }
    let(:steam_id3) { '[U:1:94714121]' }
    let(:steam_id64) { 76561198054979849 }

    it 'calculates steamid64 from steamid' do
      expect(described_class.from(steam_id).id64).to eq steam_id64
    end

    it 'calculates steamid3 from steamid' do
      expect(described_class.from(steam_id).id3).to eq steam_id3
    end

    it 'calculates steamid from steamid64' do
      expect(described_class.from(steam_id64).id).to eq steam_id
    end

    it 'calculates steamid3 from steamid64' do
      expect(described_class.from(steam_id64).id3).to eq steam_id3
    end

    it 'calculates steamid64 from steamid3' do
      expect(described_class.from(steam_id3).id64).to eq steam_id64
    end

    it 'calculates steamid from steamid3' do
      expect(described_class.from(steam_id3).id).to eq steam_id
    end
  end

  context 'with part = 0' do
    let(:steam_id) { 'STEAM_0:0:41668055' }
    let(:steam_id3) { '[U:1:83336110]' }
    let(:steam_id64) { 76561198043601838 }

    it 'calculates steamid64 from steamid' do
      expect(described_class.from(steam_id).id64).to eq steam_id64
    end

    it 'calculates steamid3 from steamid' do
      expect(described_class.from(steam_id).id3).to eq steam_id3
    end

    it 'calculates steamid from steamid64' do
      expect(described_class.from(steam_id64).id).to eq steam_id
    end

    it 'calculates steamid3 from steamid64' do
      expect(described_class.from(steam_id64).id3).to eq steam_id3
    end

    it 'calculates steamid64 from steamid3' do
      expect(described_class.from(steam_id3).id64).to eq steam_id64
    end

    it 'calculates steamid from steamid3' do
      expect(described_class.from(steam_id3).id).to eq steam_id
    end
  end
end
