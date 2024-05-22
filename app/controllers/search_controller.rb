class SearchController < ApplicationController
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

    Rails.logger.debug "Received query: #{query}"
    Rails.logger.debug "IP address: #{ip_address}, User identifier: #{user_identifier}"

    last_query = SearchQuery.where(ip_address: ip_address, user_identifier: user_identifier).order(created_at: :desc).first

    # Check if the new query is a completion of the last query
    if last_query && query.start_with?(last_query.query) && !last_query.completed
      last_query.update(query: query)
    else
      SearchQuery.create(ip_address: ip_address, user_identifier: user_identifier, query: query, completed: false)
    end

    # Only mark the query as completed if it is sufficiently different from the previous query to be considered a final search
    if query != last_query&.query
      last_query.update(completed: true) if last_query

      # Analytics update
      analytics = SearchAnalytics.find_or_create_by(query: query)
      Rails.logger.debug "Before Update: #{analytics.inspect}"
      analytics.update(count: analytics.count.to_i + 1)
      Rails.logger.debug "After Update: #{analytics.inspect}"
    end

    render json: { message: 'Query logged successfully' }
  end
end
