Rails.application.routes.draw do
  resources :sessions, only: %i[new create]
  resources :messages, only: %i[create index]

  delete '/sessions', to: 'sessions#destroy'
end
