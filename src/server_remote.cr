require "redis"
require "http/server"

hostname = "0.0.0.0"
port = 7017
REDIS_HOST = "service.pinchito.es"
REDIS_PORT = 7079

server = HTTP::Server.new do |context|
  request = context.request
  response = context.response
  paths = context.request.path.split("/")

  if (paths.size < 3 || paths[0] != "" || paths[1] != "turno")
    response.status_code = 400
    response.print "Invalid URL #{request.path}"
    next
  end

  id = get_result(paths[2])

  response.content_type = "application/json"
  response.status_code = 200
  response.print get_result(id)
end

address = server.bind_tcp port
server.listen

def get_result(id)
  puts "id: #{id}"
  redis = Redis.new(host: REDIS_HOST, port: REDIS_PORT)
  result = redis.incr(id)
  "#{result}"
end
