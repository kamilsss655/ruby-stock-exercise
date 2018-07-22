Rails.application.routes.draw do
  root to: 'stocks#index'
  resources :stocks, only: %i[create index update destroy]
end
