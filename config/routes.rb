Rails.application.routes.draw do
  get 'schedules/index'
  root 'pages#home'
  get 'home', to:'pages#home'
  get 'schedule', to: 'pages#schedule'
  get 'standings', to: 'pages#standings'

  resources :teams, only: [:index]

  resources :weeks, only: [:show] do
    post 'upload_csv', on: :collection
    get 'upload_csv_form', on: :collection
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
