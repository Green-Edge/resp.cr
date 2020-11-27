require "log"
require "socket"

module RESP
  class Server
    Log = ::Log.for(self)
    @running = false

    def initialize(@host = "0.0.0.0", @port : String | Int32 = 6379)
      @server = TCPServer.new(@host, @port.to_i)
      Log.debug {"#{self.class}: service listen on #{@host}:#{@port}"}
    end

    def listen(&block : RESP::Connection ->)
      while socket = @server.accept?
        spawn process(socket, block)
      end
    end

    def process(socket, block)
      connection = Connection.new(socket)
      begin
        block.call(connection)
      rescue ex
        Log.debug {"#{self.class}: error: #{ex}"}
      end
    end
  end
end
