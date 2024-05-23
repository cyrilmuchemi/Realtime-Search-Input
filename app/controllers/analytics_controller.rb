class AnalyticsController < ApplicationController
  before_action :set_redis_service

  def index
    Rails.logger.debug "SearchAnalytics is defined: #{defined?(SearchAnalytics)}"
    @top_searches = retrieve_top_searches_from_redis
  rescue Redis::ConnectionError => e
    Rails.logger.error "Error connecting to Redis: #{e.message}"
    @top_searches = []
  end

  private

  def set_redis_service
    @redis_service = RedisService.new
  end

  def retrieve_top_searches_from_redis
    top_searches_with_scores = @redis_service.zrevrangebyscore("top_searches", 1, "+inf")
    top_searches = top_searches_with_scores.map do |search, score|
      { query: search, count: score.to_i }
    end
    top_searches
  rescue Redis::BaseError => e
    Rails.logger.error "Error retrieving from Redis: #{e.message}"
    []
  end
end
