Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  get "/member-data", to: "members#show"


  namespace :api do
    namespace :v1 do
      resources :products
      resources :orders, only: [:create]
    end
  end
end
