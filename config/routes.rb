Rails.application.routes.draw do

  get 'sessions/new'
  root 'welcome#index'
  resources :users
  resources :sessions
  resources :user_steps

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
