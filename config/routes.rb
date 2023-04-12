Rails.application.routes.draw do
  root 'home#top'
  get 'create_user_modal', to: "home#create_user_modal"
  get 'login_modal', to: "home#login_modal"
  resources :users
  post 'session/login'
  get 'session/logout'
  get 'episode_rate/edit'
  get 'works/show'
  get 'works/index'
  get 'users/edit'
  
  get 'home/top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
