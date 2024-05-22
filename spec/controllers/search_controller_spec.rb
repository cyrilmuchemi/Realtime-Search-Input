require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'POST #query' do
    context 'with valid query' do
      let(:valid_query) { 'ruby on rails' }

      it 'returns success and creates a search query' do
        post :valid_query
        expect(response).to have_http_status(:ok)
        expect(SearchQuery.where(query: valid_query)).to exist
      end
    end

    context 'with empty query' do
      let(:empty_query) { '' }

      it 'returns bad request and does not create a search query' do
        post :empty_query
        expect(response).to have_http_status(:bad_request)
        expect(SearchQuery.count).to eq(0)
      end
    end
  end
end
