Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

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

    get 'marks_reports/new', to: 'marks_reports#new', as: :new_marks_report
    post 'marks_reports/generate_report', to: 'marks_reports#generate_report', as: :generate_marks_report, defaults: { format: :pdf }
    get 'marks_reports/generate_report_redirect', to: redirect('/marks_reports/new'), as: :generate_marks_report_redirect

    resources :users

    get "up" => "rails/health#show", as: :rails_health_check

    resources :attestation_retake_reports, only: [] do
      collection do
        get 'select'
        get 'generate_report', action: :generate_report, as: :generate_report
      end
    end

    root "home#home"
    get "users/:id/edit_password", to: "users#edit_password", as: :edit_password
    get "users/:id/edit_email", to: "users#edit_email", as: :edit_email
    post "users/:id/update_password", to: "users#update_password", as: :update_password
    post "users/:id/update_email", to: "users#update_email", as: :update_email

    resources :users, only: %i[show update edit create new destroy]
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
    resources :grades do
      collection do
        post 'find'
      end
    end
    resources :record_books

    get 'extends_reports/index'
    resources :individual_reports, only: [:new] do
      post 'generate_report', on: :collection
    end

    get 'about', to: 'home#about', as: :about

   
  end
end
