require "../src/server"
require "http/server"
require "http/server/handler"

require "mocks/spec"

Mocks.create_mock HTTP::Server do
  mock bind_tcp(host, port)
  mock listen
end

describe Server do
  describe "#serve" do
    it "should setup all resources and start listening to requests" do
      allow(HTTP::Server).to receive(Server.middlewares)
        .and_return(HTTP::Server.new(Server.middlewares))
      allow(HTTP::Server).to receive(bind_tcp("localhost", 4000))
        .and_return("address")
      allow(HTTP::Server).to receive(listen)
        .and_return("listening")

      Server.serve(4000).should eq "listening"
    end
  end
end
