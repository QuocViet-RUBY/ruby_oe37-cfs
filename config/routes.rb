Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :chart
    resources :account_activations, only: [:edit]
    resources :plans, only: [:index, :new , :create]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :categories, only: [:index, :create, :destroy]
    resources :shares, only: [:index, :new, :create] do
      collection do
        get "/get_month_from_user_shared/:from_user_id", to: "shares#get_month_from_user_shared"
      end
    end
    namespace :admin do
      resources :users, only: [:index, :show]
    end
  end
end
