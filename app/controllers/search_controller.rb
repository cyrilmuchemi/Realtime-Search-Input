class SearchController < ApplicationController
  def index
  end

  def query
    query = params[:query]
    ip_address = request.remote_ip
    user_identifier = session.id.to_s

    if query.nil? || query.strip.empty?
      render json: { error: 'Query parameter is missing or empty' }, status: :bad_request
      return
    end

    Rails.logger.debug "Received query: #{query}"
    Rails.logger.debug "IP address: #{ip_address}, User identifier: #{user_identifier}"

    search_query = SearchQuery.find_or_create_by(ip_address: ip_address, user_identifier: user_identifier)
    search_query.update(query: query)

    analytics = SearchAnalytics.find_or_create_by(query: query)
    Rails.logger.debug "Before Update: #{analytics.inspect}"
    analytics.update(count: analytics.count.to_i + 1)
    Rails.logger.debug "After Update: #{analytics.inspect}"

    render json: { message: 'Query logged successfully' }
  end
end
