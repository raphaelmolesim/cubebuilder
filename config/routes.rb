Rails.application.routes.draw do
  get 'card/search'

  get 'home/index'

  resources :architypes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
