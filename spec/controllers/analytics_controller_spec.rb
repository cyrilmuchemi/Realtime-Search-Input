require 'rails_helper'

RSpec.describe AnalyticsController, type: :controller do
  before do
    FactoryBot.create_list(:search_analytics, 3)
  end

  it 'includes a specific search query in top searches' do
    search_analytics = FactoryBot.create(:search_analytics, query: 'ruby on rails', count: 5)
    expect(response).to have_http_status(:ok)
    expect(assigns(:top_searches)).to be_nil_or_include(search_analytics)
  end
end
