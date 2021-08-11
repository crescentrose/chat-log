require 'rails_helper'

RSpec.describe ParseLogFileJob, type: :job do
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }
  let(:log_file) { create(:log_file, server: berlin) }

  describe '#perform' do
    before { ActiveJob::Base.queue_adapter = :test }

    it 'enqueues the job' do
      expect {
        described_class.perform_later(log_file)
      }.to have_enqueued_job
    end

    it 'parses the messages' do
      expect { described_class.perform_now(log_file) }
        .to change { Message.all.size }
        .by(27)
      message = Message.first
      expect(message.message).to eq('rtv')
      expect(message.sent_at).to eq(Time.utc(2021, 7, 30, 20, 32, 36))
    end

    it 'parses votekick events' do
      expect { described_class.perform_now(log_file) }
        .to change { VotekickEvent.all.size }
        .by(1)
      event = VotekickEvent.first
      expect(event.target_name).to eq('VIORA')
      expect(event.time).to eq(Time.utc(2021, 8, 1, 14, 49, 29))
    end

    it 'parses connects' do
      expect { described_class.perform_now(log_file) }
        .to change { ConnectionEvent.all.size }
        .by(1)
      event = ConnectionEvent.first
      expect(event.player_name).to eq('Solymr ibn Wali Barad')
      expect(event.connected_at).to eq(Time.utc(2021, 7, 30, 20, 32, 11))
      expect(event.ip).to eq('127.0.0.1')
    end

    it 'parses disconnects' do
      expect { described_class.perform_now(log_file) }
        .to change { DisconnectionEvent.all.size }
        .by(1)
      event = DisconnectionEvent.first
      expect(event.player_name).to eq('viddy')
      expect(event.reason).to eq('Client left game (Steam auth ticket has been canceled')
    end
  end
end
