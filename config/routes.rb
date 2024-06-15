Rails.application.routes.draw do
  get 'extends_reports/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'users/search', to: 'users/registrations#search'
    post 'users/find_user', to: 'users/registrations#find_user'
    put 'users/set_password_and_email', to: 'users/registrations#set_password_and_email'

  end

  Rails.application.routes.draw do
    get 'marks_reports/new', to: 'marks_reports#new', as: :new_marks_report
    post 'marks_reports/generate_report', to: 'marks_reports#generate_report', as: :generate_marks_report, defaults: { format: :pdf }
    get 'marks_reports/generate_report_redirect', to: redirect('/marks_reports/new'), as: :generate_marks_report_redirect
  end

  Rails.application.routes.draw do
    resources :users
  end

  ActiveAdmin.routes(self) do
    devise_for :admin_users, ActiveAdmin::Devise.config
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post 'admin/dashboard/generate_report', to: 'admin/dashboard#generate_report'

  namespace :admin do
    get 'dashboard/generate_report', to: 'dashboard#generate_report'
  end

  resources :attestation_retake_reports, only: [] do
    collection do
      get 'select'
      get 'generate_report', action: :generate_report, as: :generate_report
    end
  end

  # Defines the root path route ("/")
  root "home#home"
  get "users/:id/edit_password", to: "users#edit_password", as: :edit_password
  get "users/:id/edit_email", to: "users#edit_email", as: :edit_email
  post "users/:id/update_password", to: "users#update_password", as: :update_password
  post "users/:id/update_email", to: "users#update_email",as: :update_email
  resources :users, only: %i[show update edit ]
  resources :semesters
  resources :subjects
  resources :groups do
    get '/subjects', to: 'subjects#group_subjects', on: :member
    get :form_teacher

  end
  resources :specializations
  resources :notifications do
    member do
      patch :mark_as_read
    end
  end
  resources :intermediate_attestations
  resources :grades
  resources :record_books

  Rails.application.routes.draw do
  get 'extends_reports/index'
    resources :individual_reports, only: [:new] do
      post 'generate_report', on: :collection
    end
  end

  get 'admin_panel/index', as: 'admin_panel'

  get 'about', to: 'home#about', as: :about
end
