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
  
      previous_query = SearchQuery.where(ip_address: ip_address, user_identifier: user_identifier).order(created_at: :desc).first
  
      if previous_query.nil? || previous_query.query.nil? || !query.start_with?(previous_query.query)
        SearchQuery.create(query: query, ip_address: ip_address, user_identifier: user_identifier)
      end
  
      render json: { message: 'Query logged successfully' }
    end
  end
  
  
