Rails.application.routes.draw do
  devise_for :users
  get 'session/logout'
  get 'home/row_data'

  resources :cubes do
    member do
     put 'add_archetype'
     put 'remove_archetype'
     get 'view'
     post 'set_wishlist'
     get 'wishlist'
    end
  end
  
  resources :archetypes do 
    member do
      put 'add_card'
      delete 'remove_card'
    end
  end

  get 'card/search'
  get '/card/:id', to: "card#show"
  root to: 'cubes#index'
  get 'home/restore_LocalStorage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
