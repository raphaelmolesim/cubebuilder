Rails.application.routes.draw do
  get 'session/logout'
  get 'home/row_data'

  get 'cubes/wishlist'
  post 'cubes/set_wishlist'
  resources :cubes
  resources :architypes
  get 'card/cube_load'
  get 'card/search'
  get '/card/:id', to: "card#show"
  root to: 'home#index'
  get 'home/restore_LocalStorage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
