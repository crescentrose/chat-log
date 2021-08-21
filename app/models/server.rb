# == Schema Information
#
# Table name: servers
#
#  id                 :bigint           not null, primary key
#  friendly_name      :string           not null
#  ip                 :string           not null
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
#  ssh_key_id         :bigint
#
# Indexes
#
#  index_servers_on_ssh_key_id  (ssh_key_id)
#
# Foreign Keys
#
#  fk_rails_...  (ssh_key_id => ssh_keys.id)
#
class Server < ApplicationRecord
  validates :name, presence: true

  belongs_to :ssh_key, optional: true

  # why did I make this?
  def self.from_name(name)
    find_by(name: name)
  end

  def health
    return :critical if rcon_password && !last_update.nil? && last_update < 2.minutes.ago
    return :status_only if ssh_key_id.nil?

    case last_log_sync
    when 30.minutes.ago..Time.now.utc
      :ok
    when 2.hours.ago..30.minutes.ago
      :warn
    else
      :offline
    end
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
end
