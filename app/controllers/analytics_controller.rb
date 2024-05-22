class AnalyticsController < ApplicationController
  def index
    Rails.logger.debug "SearchAnalytics is defined: #{defined?(SearchAnalytics)}"
    @top_searches = SearchAnalytics.order(count: :desc).limit(10)
  end
end

