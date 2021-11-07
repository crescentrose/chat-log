require 'async'
require 'async/io'

Async do |_task|
  socket = Async::IO::Socket.bind(Async::IO::Address.udp('127.0.0.1', 27_005))
  socket.connect(Async::IO::Address.udp('127.0.0.1', 27_115))

  loop do
    socket.send('RL 11/07/2021 - 18:43:18: "Erratum<35><[U:1:129159611]><Red>" say "rip"' + "\n")
    sleep 0.01
  end
end
