Rails.application.routes.draw do
  get 'session/logout'

  resources :cubes
  get 'card/cube_load'
  get 'card/search'
  get '/card/:id', to: "card#show"
  
  get 'home/index'

  resources :architypes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
