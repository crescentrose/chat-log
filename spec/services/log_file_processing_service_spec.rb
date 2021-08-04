require 'rails_helper'

RSpec.describe LogFileProcessingService do
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }
  let(:contents) do
    "L 01/01/1970 - 00:00:00: \"foo<0><[U:0:000000]><Red>\" say \"I am naughty \xD1\""
  end
  let(:log_file) { create(:log_file, server: berlin, contents: contents) }

  it 'ensures cheeky little buggers do not fuck encoding up' do
    log = subject.process(log_file)
    expect(log.first.message).to eq('I am naughty �')
  end
end
