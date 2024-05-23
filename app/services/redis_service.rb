class RedisService
  def initialize
    @redis = Redis.new(url: ENV['REDIS_URL'])
  rescue Redis::BaseError => e
    Rails.logger.error "Error connecting to Redis: #{e.message}"
    raise e
  end

  def hincrby(key, field, increment)
    result = @redis.hincrby(key, field, increment)
    Rails.logger.debug "HINCRBY - Key: #{key}, Field: #{field}, Increment: #{increment}, Result: #{result}"
    result
  rescue Redis::BaseError => e
    Rails.logger.error "Redis error on HINCRBY: #{e.message}"
    nil
  end

  def zrevrangebyscore(key, min, max)
    result = @redis.zrevrangebyscore(key, min, max, withscores: true)
    Rails.logger.debug "ZREVRANGEBYSCORE - Key: #{key}, Min: #{min}, Max: #{max}, Result: #{result}"
    result
  rescue Redis::BaseError => e
    Rails.logger.error "Redis error on ZREVRANGEBYSCORE: #{e.message}"
    []
  end

  def zincrby(key, increment, member)
    result = @redis.zincrby(key, increment, member)
    Rails.logger.debug "ZINCRBY - Key: #{key}, Increment: #{increment}, Member: #{member}, Result: #{result}"
    result
  rescue Redis::BaseError => e
    Rails.logger.error "Redis error on ZINCRBY: #{e.message}"
    nil
  end
end
