Rails.application.routes.draw do
  resources :sessions, only: %i[new create]
  resources :messages, only: %i[create]

  delete '/sessions', to: 'sessions#destroy'
end
