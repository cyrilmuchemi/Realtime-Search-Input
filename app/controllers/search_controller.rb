class SearchController < ApplicationController
  before_action :set_redis_service, only: [:query]

  def index
  end

  def query
    query = params[:query].strip
    ip_address = request.remote_ip
    user_identifier = session.id.to_s

    if query.empty?
      flash[:error] = 'Query parameter is missing or empty'
      redirect_to root_path # Redirect to the root path or any other appropriate path
      return
    end

    key = "search_queries:#{user_identifier}"
    @redis_service.hincrby(key, query, 1)

    redirect_to analytics_path # Redirect to the analytics page
  rescue Redis::BaseError => e
    Rails.logger.error "Error interacting with Redis: #{e.message}"
    flash[:error] = 'Internal server error'
    redirect_to root_path # Redirect to the root path or any other appropriate path
  end

  private

  def set_redis_service
    @redis_service = RedisService.new
  rescue Redis::BaseError => e
    Rails.logger.error "Error initializing RedisService: #{e.message}"
    flash[:error] = 'Internal server error'
    redirect_to root_path # Redirect to the root path or any other appropriate path
  end
end
