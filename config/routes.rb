Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #? RESTFUL
  # verb 'path', to: 'controller#action'
  # get '/chirps', to: 'chirps#index'
  # get '/chirps/:id', to: 'chirps#show' # /chirps/12
  # post '/chirps', to: 'chirps#create'
  # patch '/chirps/:id', to: 'chirps#update'
  # delete '/chirps/:id', to: 'chirps#destroy'

  #! NOT RESTFUL
  # get '/chirps/search/:query', to: 'chirps#search'

  # resources :name_of_resource, options hash
  resources :chirps, except: [:new, :edit]
  # resources :chirps, only: [:index, :show, :create, :update, :destroy]

  resources :users
end
