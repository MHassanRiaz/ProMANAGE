Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :projects
  resource :profile, only: [ :show, :edit, :update ]
  # config/routes.rb
  namespace :admin do
    get "users/index"
    get "users/switch"
    resources :users, only: [ :index, :new, :create ] do
      member do
        patch :approve
      end
    end

      resources :users, only: [ :index ] do

        member do
          get :switch
        end
        member do
          patch :toggle_access
        end
      end
  end
  root "home#index"

    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get "up" => "rails/health#show", as: :rails_health_check


  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_scope :user do
    get "users/sign_out", to: "devise/sessions#destroy"
  end
  # Add this line to mount the SwitchUser route
  mount SwitchUser::Engine => "/switch_user"
  # Defines the root path route ("/")

  # root "posts#index"
end
