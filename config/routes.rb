Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :task  #, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  # post 'users', to: 'users#create'
  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'
end
 