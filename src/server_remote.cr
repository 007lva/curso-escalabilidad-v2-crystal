require "redis"
require "http/server"

hostname = "0.0.0.0"
port = 7017
redis_host = "service.pinchito.es"
redis_port = 7079

server = HTTP::Server.new do |context|
  context.response.content_type = "application/json"
  context.response.print "Hello world! The time is #{Time.local}"
end

address = server.bind_tcp port
server.listen
