require 'rails_helper'

RSpec.describe AnalyticsController, type: :controller do

  before do
    @search_analytics = FactoryBot.create(:search_analytic, 3, completed: true) 
  end

  describe 'GET #index' do

    context 'with existing search analytics' do
      before { SearchAnalytics.update_analytics }

      it 'returns top 10 searches and logs defined status' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(assigns(:top_searches).count).to eq(10)
        expect(response.body).to include("SearchAnalytics is defined: true")
      end
    end

    context 'with no search analytics' do
      it 'returns an empty array' do
        allow(SearchAnalytics).to receive(:order).and_return([])
  
        get :index
        expect(response).to have_http_status(:ok)
        expect(assigns(:top_searches)).to be_empty
      end
    end

    context 'with a specific search query' do
      let(:search_analytics) { 'ruby on rails' }
  
      before do
        SearchAnalytics.create(query: search_analytics, count: 5)
      end
  
      it 'includes the search query in top searches' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(assigns(:top_searches).map(&:query)).to include(search_analytics)
      end
    end
    
  end
end
