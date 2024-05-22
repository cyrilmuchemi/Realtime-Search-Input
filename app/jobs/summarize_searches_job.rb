class SummarizeSearchesJob < ApplicationJob
  queue_as :default

  def perform
    SearchQuery.find_each do |search_query|
      SearchAnalytics.find_or_create_by(query: search_query.query).increment!(:count)
    end
  end
end

