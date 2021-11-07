#!/usr/bin/env ruby

require 'socket'

socket = UDPSocket.new
socket.bind('0.0.0.0', 27_115)

begin
  loop do
    data, origin = socket.recvfrom(16)
    p data, origin
    server.send('ok', 0, origin[3], 27_115)
  end
ensure
  puts 'closing socket'
  socket.close
end

# require 'async'
# require 'async/io'

# port = ENV.fetch('UNCLETOPIA_UDP_LOG_PORT', 27_115)
# endpoint = Async::IO::Endpoint.udp('0.0.0.0', port)

# def process(input, origin)
#   Async do |task|
#     task.with_timeout(1) do
#       puts "[#{origin.ip_address}:#{origin.ip_port}] #{input.strip}"
#     rescue Async::TimeoutError
#       puts "[!!] took too long to process \"#{input}\" from #{origin}"
#     end
#   end
# end

# Async do |_task|
#   endpoint.bind do |socket|
#     loop do
#       data, address = socket.sysread(100)
#       process(data, address)
#     end
#   end
# end
