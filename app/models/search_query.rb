class SearchQuery < ApplicationRecord
    belongs_to :user, optional: true  # Optional association if needed
    validates :query, presence: true
    validates :complete_query, presence: true
end
