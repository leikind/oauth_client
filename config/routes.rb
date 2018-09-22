Rails.application.routes.draw do
  resources :users do

    member do
      put :refresh_authentication
      put :update_attribute
      post :move_authentication_to
    end

  end
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
