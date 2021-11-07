require 'resolv'

class ChangeServerHostnamesToIPs < ActiveRecord::Migration[6.1]
  def change
    Server.find_each do |server|
      server.update(ip: Resolv.getaddress(server.ip))
    rescue Resolv::ResolvError
      puts "no IP for #{server.id}"
      next
    end
  end
end
