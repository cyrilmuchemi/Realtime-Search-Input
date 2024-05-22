require 'rails_helper'

RSpec.describe SearchQuery, type: :model do
  it { should validate_presence_of(:query) }

  describe 'completed query' do
    let(:search_query) { FactoryBot.create(:search_query, query: 'what is ruby on rails?') }

    it 'identifies a complete query' do
      expect(search_query.completed).to be(true)
    end
  end

  describe 'incomplete query' do
    let(:search_query) { FactoryBot.create(:search_query, query: 'what is ruby') }

    it 'identifies an incomplete query' do
      expect(search_query.completed).to be(false)
    end
  end
end
