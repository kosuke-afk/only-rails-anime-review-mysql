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
      patch ':user_id/works_rate/update', to: 'works_rate#update', as: :update_rate
    end
    get 'search', on: :collection
  end

  post 'session/login'
  delete 'session/logout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
