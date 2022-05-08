require 'async'
require 'async/io'

Async do |_task|
  socket = Async::IO::Socket.bind(Async::IO::Address.udp('127.0.0.1', 27_005))
  socket.connect(Async::IO::Address.udp('127.0.0.1', 27_115))

  while true do
    datetime = DateTime.now.strftime("%m/%d/%Y - %H:%M:%S")
    message = ["poop", "smelly", "test", "rtv", "scramble", "message", "very funny", "scrimblo", "sniper op"].sample
    socket.send("    RL #{datetime}: \"best gamer EU<2><[U:1:94714121]><Red>\" say \"#{message}\"" + "\n")
    sleep 5
  end
end
