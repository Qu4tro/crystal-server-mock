require "http/server"
require "http/server/handler"

class Server
  def self.serve(port, io = STDOUT)
    self.server.tap do |server|
      address = server.bind_tcp "localhost", port
      io.puts "Listening on http://#{address}"
      server.listen
    end
  end

  def self.server
    HTTP::Server.new(self.middlewares)
  end

  def self.middlewares
    [
      HTTP::LogHandler.new.as(HTTP::Handler),
      HTTP::ErrorHandler.new,
    ] 
  end
end
