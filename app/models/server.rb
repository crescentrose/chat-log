# == Schema Information
#
# Table name: servers
#
#  id                 :bigint           not null, primary key
#  friendly_name      :string           not null
#  ip                 :string           not null
#  is_active          :boolean          default(TRUE), not null
#  last_log_sync      :datetime
#  last_update        :datetime
#  last_uploaded_file :string
#  map                :string
#  name               :string           not null
#  players            :integer
#  port               :integer          default(27015), not null
#  rcon_password      :string
#  timezone           :string           default("UTC")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Server < ApplicationRecord
  validates :name, presence: true

  has_many :connection_events, dependent: :delete_all
  has_many :disconnection_events, dependent: :delete_all
  has_many :messages, dependent: :delete_all
  has_many :votekick_events, dependent: :delete_all

  before_save :convert_hostname_to_ip

  scope :active, -> { where(is_active: true) }

  # why did I make this?
  def self.from_name(name)
    find_by(name: name)
  end

  def health
    return :offline unless is_active?

    :status_only
  end

  def rcon_client
    raise 'rcon password must exist to use rcon client' if rcon_password.nil?
    return @rcon_client unless @rcon_client.nil?

    @rcon_client = Rcon::Client.new(
      host: ip,
      port: port,
      password: rcon_password
    )
    @rcon_client.authenticate!
    @rcon_client
  end

  def last_log_sync_local
    last_log_sync&.in_time_zone(timezone)
  end

  def private_key
    ssh_key&.private_key&.gsub(/\r\n?/, "\n")
  end

  def convert_hostname_to_ip
    self.ip = Resolv.getaddress(ip)
  rescue Resolv::ResolvError
    # TODO: log
  end
end
