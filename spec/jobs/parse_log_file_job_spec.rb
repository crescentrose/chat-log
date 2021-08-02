require 'rails_helper'

RSpec.describe ParseLogFileJob, type: :job do
  let(:log_file) { create(:log_file) }

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
    end
  end
end
