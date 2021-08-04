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

    it 'parses the file' do
      expect { described_class.perform_now(log_file) }
        .to change { Message.all.size }
        .by(27)
      message = Message.first
      expect(message.message).to eq('rtv')
      expect(message.sent_at).to eq(Time.utc(2021, 7, 30, 20, 32, 36))
    end
  end
end
