class RedisService
    def initialize
      @redis = Redis.new(host: "red-c6na6rjru51t7lilgs3g", port: 6379)
    end
  
    def hincrby(key, field, increment)
      @redis.hincrby(key, field, increment)
    rescue Redis::BaseError => e
      Rails.logger.error "Redis error on HINCRBY: #{e.message}"
      nil
    end
  
    def zrevrangebyscore(key, min, max)
      @redis.zrevrangebyscore(key, min, max, withscores: true)
    rescue Redis::BaseError => e
      Rails.logger.error "Redis error on ZREVRANGEBYSCORE: #{e.message}"
      []
    end
  
    def zincrby(key, increment, member)
      @redis.zincrby(key, increment, member)
    rescue Redis::BaseError => e
      Rails.logger.error "Redis error on ZINCRBY: #{e.message}"
      nil
    end
  end
  