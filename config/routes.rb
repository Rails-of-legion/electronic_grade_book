Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    get 'extends_reports/index'
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

    devise_scope :user do
      get 'users/search', to: 'users/registrations#search', as: :users_search
      post 'users/find_user', to: 'users/registrations#find_user'
      put 'users/set_password_and_email', to: 'users/registrations#set_password_and_email'
      patch 'users/:id', to: 'users/registrations#update', as: :update_user_registration
    end

    get 'marks_reports/new', to: 'marks_reports#new', as: :new_marks_report
    post 'marks_reports/generate_report', to: 'marks_reports#generate_report', as: :generate_marks_report
    get 'marks_reports/generate_report_redirect', to: redirect('/marks_reports/new'), as: :generate_marks_report_redirect
    resources :users do
      collection do
        get :export_users_to_xlsx
      end
    end

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
    patch "users/:id/update_password", to: "users#update_password", as: :update_password
    patch "users/:id/update_email", to: "users#update_email", as: :update_email

    resources :users, only: %i[show update edit create new destroy edit_password update_password edit_email update_email] 

    resources :semesters
    resources :subjects do
      collection do
        get 'group_subjects', to: 'subjects#group_subjects_spec'
      end
    end
    resources :groups do
      get '/subjects', to: 'subjects#group_subjects', on: :member
      get :form_teacher
      collection do
        get 'by_specialization/:id', to: 'groups#by_specialization', as: :by_specialization
      end
    end
    resources :specializations do
      member do
        get 'groups', to: 'groups#by_specialization'
      end
    end
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

    get 'reports/generate_interim_report/:intermediate_attestation_id', 
    to: 'reports#generate_interim_report', as: 'generate_interim_report'

    get 'about', to: 'home#about', as: :about
  end
end
