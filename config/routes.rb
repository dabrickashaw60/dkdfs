Rails.application.routes.draw do
  devise_for :users

  # Publicly accessible routes
  root 'pages#home' # Home page should be public
  get 'home', to: 'pages#home'
  get 'schedule', to: 'pages#schedule'
  get 'standings', to: 'pages#standings'

  # Admin dashboard restricted to admin users
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :teams, only: [:edit, :update, :index]
    get 'weeks/upload_csv_form', to: 'weeks#upload_csv_form'
  end

  resources :teams, only: [:index]
  resources :weeks, only: [:show] do
    post 'upload_csv', on: :collection
    get 'upload_csv_form', on: :collection
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
