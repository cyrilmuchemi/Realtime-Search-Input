Rails.application.routes.draw do
  get 'home', to: 'home#index'
  root 'home#index'
  get 'search', to: 'search#index'
  get 'analytics', to: 'analytics#index'
  get 'search/query', to: 'search#query'
end


