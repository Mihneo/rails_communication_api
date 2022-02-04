Rails.application.routes.draw do
  resources :users

  resources :sessions, only: %i[new create]

  delete '/sessions', to: 'sessions#destroy'
end
