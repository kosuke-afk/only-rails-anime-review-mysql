Rails.application.routes.draw do
  root 'home#top'
  get 'create_user_modal', to: "home#create_user_modal"
  get 'login_modal', to: "home#login_modal"
  resources :users, only: [:edit,:create] do 
    member do
      resources :episode_rates, only: [:edit,:update]
    end
  end

  resources :works, only: [:index,:show] do
    member do
      resources :work_rates, only: [:update]
    end
    get 'search', on: :collection
  end

  post 'session/login'
  delete 'session/logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
