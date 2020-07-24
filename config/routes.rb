Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get   '/login', :to => 'sessions#new', :as => :login
  #get '/auth/:provider/callback', :to => 'sessions#create'
  #get '/auth/failure', :to => 'sessions#failure'
  
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  devise_scope :user do
    get 'login', to: 'sessions#new', as: :new_user_session
    get 'sign_out', to: 'sessions#destroy', as: :destroy_user_session
  end
  post '/save_fav_streamer', to: 'dashboard#save_fav_streamer'
  post '/webhooks/event', to: 'dashboard#webhooks'
  get '/webhooks/event', to: 'dashboard#get_webhooks'
  root 'dashboard#index'
  
end
