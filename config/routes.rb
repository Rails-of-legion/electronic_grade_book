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
  resources :users, only: %i[index show]
  resources :semesters
  resources :subjects
  resources :attendances
  resources :groups
  resources :specializations
  resources :notifications
  resources :intermediate_attestations
  resources :grades
  resources :record_books
  get 'about', to: 'home#about', as: :about
end
