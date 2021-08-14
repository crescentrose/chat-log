# == Schema Information
#
# Table name: servers
#
#  id            :bigint           not null, primary key
#  friendly_name :string           not null
#  ip            :string           not null
#  last_update   :datetime
#  name          :string           not null
#  port          :integer          default(27015), not null
#  rcon_password :string
#  timezone      :string           default("UTC")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Server < ApplicationRecord
  validates :name, presence: true

  # why did I make this?
  def self.from_name(name)
    find_by(name: name)
  end
end
