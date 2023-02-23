Rails.application.routes.draw do
  root 'home#top'
  resources :users
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
