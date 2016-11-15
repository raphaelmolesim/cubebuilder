Rails.application.routes.draw do
  get 'card/search'
  get 'card/cube_load'

  get 'home/index'

  resources :architypes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
