require "rails_helper"

RSpec.describe ProcessLogFileJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs 
  end

  describe '#perform' do
    let(:log_file) { create(:log_file, body: 'L 07/30/2021 - 22:32:42: "gamer<526><[U:1:000000526]><Red>" say "._."') }

    before { ProcessLogFileJob.perform_now(log_file) }

    it { expect(Message.last.message).to eq('._.') }
    it { expect(log_file).to be_status_processed }
  end
end
