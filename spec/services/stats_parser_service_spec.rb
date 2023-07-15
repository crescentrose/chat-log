require 'rails_helper'

RSpec.describe VotekickParserService do
  let(:berlin) { create(:server, timezone: 'Europe/Berlin') }
  let(:bonca) { "[U:1:177237803]" }

  it 'does not die lol' do
    parsed_line = subject.parse_line(
      'L 07/15/2023 - 18:31:26: "Bonca<18><[U:1:177237803]><Blue>" killed "foo<7><[U:1:1234]><Red>" with "scattergun" (attacker_position "-67 1371 -135") (victim_position "-325 1571 -107")',
      berlin
    )

    expect(parsed_line).to be_nil
  end
end
