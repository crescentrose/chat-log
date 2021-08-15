require 'rails_helper'

RSpec.describe Server, type: :model do
  describe '#health' do
    it 'is OK if it has been updated in the past 30 minutes' do
      server = create(:server, last_update: 25.minutes.ago)
      expect(server.health).to eq(:ok)
    end

    it 'is warn if it has been updated in the past 2 hours' do
      server = create(:server, last_update: 1.hour.ago)
      expect(server.health).to eq(:warn)
    end

    it 'is offline if it has been updated more than 2 hours ago' do
      server = create(:server, last_update: 10.hours.ago)
      expect(server.health).to eq(:offline)
    end
  end
end
