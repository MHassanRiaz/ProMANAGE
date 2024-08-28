Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  # config/routes.rb
  resources :tasks
  resources :tasks do
    member do
      post :active

    end
  end

  resources :profiles, only: [ :show, :edit, :update ]

  resource :profile, only: [ :show, :edit, :update, :destroy ]

  resources :projects do
    member do
      get :assigned_users
    end
  end

  resources :projects do
    member do
      post :archive
      post :activate  # Added this line for the activate action
    end
  end

  namespace :admin do
    resources :users, only: [ :index, :new, :create ] do
      member do
        patch :approve
        post :assign_project
        patch :toggle_access
        post :remove_project
      end
      collection do
        get :project_assignment
        post :assign_project
        delete :remove_project
      end
    end
    get "users/switch", to: "users#switch"
  end

  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  devise_scope :user do
    get "users/sign_out", to: "devise/sessions#destroy"
  end

  mount SwitchUser::Engine => "/switch_user"
end
