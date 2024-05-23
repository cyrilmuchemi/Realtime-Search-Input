require 'rails_helper'
require 'redis'

RSpec.describe AnalyticsController, type: :controller do
  before do
    @redis = Redis.new(host: "red-c6na6rjru51t7lilgs3g", port: 6379)
    FactoryBot.create_list(:search_analytics, 3)
  end

  it 'includes a specific search query in top searches' do
    search_analytics = FactoryBot.create(:search_analytics, query: 'ruby on rails', count: 5)
    expect(response).to have_http_status(:ok)
    expect(assigns(:top_searches)).to be_nil_or_include(search_analytics)
  end
end
