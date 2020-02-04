Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/postcodes', to: 'postcode#index'
  resources :postcodes, except: [:edit,:update]
end
