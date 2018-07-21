Rails.application.routes.draw do
  resources :stocks, only: %i[create index update destroy]
end
