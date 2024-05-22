Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get 'search', to: 'search#query'
  get 'analytics', to: 'analytics#index'
end

