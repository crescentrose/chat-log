require 'socket'

socket = UDPSocket.new
socket.send("foobar", 0, '127.0.0.1', 27115)
socket.recvfrom(16)
socket.close
