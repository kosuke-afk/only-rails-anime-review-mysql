Rails.application.routes.draw do
  root 'home#top'
  post 'create_user_modal', to: "home#create_user_modal"
  post 'login_modal', to: "home#login_modal"
  
  get 'episode_rate/edit'
  get 'works/show'
  get 'works/index'
  get 'users/edit'
  get 'session/login'
  get 'session/logout'
  get 'home/top'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
