Rails.application.routes.draw do
  get 'session/logout'

  resources :cubes
  resources :architypes
  get 'card/cube_load'
  get 'card/search'
  get '/card/:id', to: "card#show"
  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
