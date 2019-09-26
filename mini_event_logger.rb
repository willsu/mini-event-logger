require 'socket'

port = ENV['PORT'] || 2003

puts "Opening TCP Server on Port: #{port}"

tcp_server = TCPServer.new(port)

loop do
  Thread.start(tcp_server.accept) do |tcp_socket|

    while (log_line = tcp_socket.gets) != nil
      $stdout.write("mini-event-logger: #{log_line}")
      $stdout.flush
    end

    tcp_socket.close
  end
end

