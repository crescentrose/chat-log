# == Schema Information
#
# Table name: flags
#
#  id                 :bigint           not null, primary key
#  reason             :string           not null
#  resolve_token      :string           not null
#  resolved_at        :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  discord_webhook_id :string
#  message_id         :bigint           not null
#
# Indexes
#
#  index_flags_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
FactoryBot.define do
  factory :flag do
    message { nil }
    flagged_at { "2021-12-15 22:45:30" }
    reason { "MyString" }
    discord_webhook_id { "MyString" }
    resolved_at { "2021-12-15 22:45:30" }
  end
end
