Rails.application.routes.draw do
  root 'home#top'
  get 'create_user_modal', to: "home#create_user_modal"
  get 'login_modal', to: "home#login_modal"
  post 'session/login'
  delete 'session/logout'
  resources :users, only: [:edit,:create] do
    member do
      get ":work_id/episodes/:episode_id/open", to: "episode_rates#edit_open", as: "open_episode_rate"
      get ":work_id/episodes/:episode_id/close", to: "episode_rates#edit_close", as: "close_episode_rate"
      patch ":work_id/episodes/:episode_id", to: "episode_rates#update", as: "update_episode_rate"
    end
  end
  resources :works, only: [:index,:show] do
    member do
      resources :work_rates, only: [:update]
    end
    get 'search', on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
