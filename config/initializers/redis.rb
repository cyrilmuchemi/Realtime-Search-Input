require 'redis'

if Rails.env.production?
  uri = URI.parse(ENV['REDIS_URL'])
  Redis.current = Redis.new(host: uri.host, port: uri.port, password: uri.password)
else
  Redis.current = Redis.new
end