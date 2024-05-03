Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do  
    get 'users/search', to: 'users/registrations#search'
    post 'users/find_user', to: 'users/registrations#find_user'
    put 'users/set_password_and_email', to: 'users/registrations#set_password_and_email' 

  end


  ActiveAdmin.routes(self) do
    devise_for :admin_users, ActiveAdmin::Devise.config
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#home"
  get "users/:id/edit_password", to: "users#edit_password", as: :edit_password
  get "users/:id/edit_email", to: "users#edit_email", as: :edit_email
  post "users/:id/update_password", to: "users#update_password", as: :update_password
  post "users/:id/update_email", to: "users#update_email",as: :update_email
  resources :users, only: %i[index show update edit ] do
    member do
        get :show, defaults: { format: :pdf }
    end
  end
  resources :semesters
  resources :subjects
  resources :groups
  resources :specializations
  resources :notifications
  resources :intermediate_attestations
  resources :grades
  resources :record_books
  get 'about', to: 'home#about', as: :about
end
