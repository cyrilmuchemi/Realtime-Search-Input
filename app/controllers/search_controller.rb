class SearchController < ApplicationController
    def query
      query = params[:query]
      ip_address = request.remote_ip
      user_identifier = session.id
  
      previous_query = SearchQuery.where(ip_address: ip_address, user_identifier: user_identifier).order(created_at: :desc).first
  
      if previous_query.nil? || !query.start_with?(previous_query.query)
        SearchQuery.create(query: query, ip_address: ip_address, user_identifier: user_identifier)
      else
        previous_query.update(query: query)
      end
  
      render json: Article.where('title LIKE ?', "%#{query}%").pluck(:title)
    end
  end
  
