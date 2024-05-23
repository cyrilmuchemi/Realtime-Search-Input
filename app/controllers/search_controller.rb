class SearchController < ApplicationController
  before_action :set_redis_service, only: [:query]

  def index
  end

  def query
    query = params[:query].strip
    ip_address = request.remote_ip
    user_identifier = session.id.to_s

    if query.empty?
      render json: { error: 'Query parameter is missing or empty' }, status: :bad_request
      return
    end

    key = "search_queries:#{user_identifier}"
    @redis_service.hincrby(key, query, 1)

    render json: { message: 'Query logged successfully' }
  rescue Redis::BaseError => e
    Rails.logger.error "Error interacting with Redis: #{e.message}"
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end

  private

  def set_redis_service
    @redis_service = RedisService.new
  end
end
