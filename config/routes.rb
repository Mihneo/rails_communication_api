Rails.application.routes.draw do
  resources :users

  resources :sessions, only: %i[new create destroy]

  delete '/sessions', to: 'sessions#destroy'
end
