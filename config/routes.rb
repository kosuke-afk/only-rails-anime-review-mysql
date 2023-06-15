Rails.application.routes.draw do
  root 'home#top'
  get 'create_user_modal', to: "home#create_user_modal"
  get 'login_modal', to: "home#login_modal"
  post 'session/login'
  delete 'session/logout'
  resources :users, only: [:show,:edit,:create] do
    resources :work_rates, only: [:index, :edit] do
      collection do
        post "ranking/total", to: "work_rates#total"
        post "ranking/impressed", to: "work_rates#impressed"
        post "ranking/love", to: "work_rates#love"
        post "ranking/comedy", to: "work_rates#comedy"
        post "ranking/excitement", to: "work_rates#excitement"
        post "ranking/deep", to: "work_rates#deep"
      end
    end
    member do
      get ":work_id/episodes/:episode_id/open", to: "episode_rates#edit_open", as: "open_episode_rate"
      get ":work_id/episodes/:episode_id/close", to: "episode_rates#edit_close", as: "close_episode_rate"
      patch ":work_id/episodes/:episode_id", to: "episode_rates#update", as: "update_episode_rate"
    end
  end
  resources :works, only: [:index,:show] do
    get 'search', on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
