# == Schema Information
#
# Table name: ssh_keys
#
#  id          :bigint           not null, primary key
#  name        :string
#  private_key :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_ssh_keys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :ssh_key do
    user
    private_key { 'this is a totally real key' }
  end
end
