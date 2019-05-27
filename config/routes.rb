Rails.application.routes.draw do

  resources :collections
  get 'password_resets/new'
  get 'sessions/new'
  root 'welcome#index'
  resources :users
  resources :sessions
  resources :user_steps


  #get '/users/:id' => 'users#show', as: :user

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/choices' => 'choices#index'

  get '/pick' => 'loggedinchoices#index'

  get 'password_resets/new'

  #get '/button', to: 'dresses#index', as: 'button'

  resources :dresses
  resources :password_resets
  resources :collections_dresses

#  get '/collections_dresses/new' => 'dresses#show'

  get '/collections_dresses' => 'collections_dresses#index'

  get '/mycollections' => 'collections#my'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
