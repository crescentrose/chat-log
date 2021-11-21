require 'async'
require 'async/io'

Async do |_task|
  socket = Async::IO::Socket.bind(Async::IO::Address.udp('127.0.0.1', 27_005))
  socket.connect(Async::IO::Address.udp('127.0.0.1', 27_115))

  socket.send('RL 08/11/2021 - 22:32:36: "LOSER<516><[U:1:000000516]><Red>" say "филип смрди"' + "\n")
  sleep 0.01
end
