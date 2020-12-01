require "log"
require "socket"

module RESP
  class Server
    Log = ::Log.for(self)
    @running = false

    def initialize(@host = "0.0.0.0", @port : String | Int32 = 6379)
      @server = TCPServer.new(@host, @port.to_i, backlog: 4096, reuse_port: true)
      @server.keepalive = true
      @server.tcp_nodelay = true
      @server.tcp_keepalive_idle = 60
      @server.tcp_keepalive_count = 10
      @server.tcp_keepalive_interval = 10
      Log.debug {"#{self.class}: service listen on #{@host}:#{@port}"}
    end

    def listen(&block : RESP::Connection ->)
      while socket = @server.accept?
        spawn handle_client(socket, block)
      end
    end

    def handle_client(socket, block)
      connection = Connection.new(socket)

      until socket.closed?
        # process each request from the connection
        begin
          block.call(connection)

        rescue IO::Error
          break

        rescue ex
          Log.error {"#{self.class}: call error: #{ex.class} #{ex}"}
        end
      end

    ensure
      socket.close
    end
  end
end
