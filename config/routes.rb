Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication
  get  "login",       to: "sessions#new"
  post "login",       to: "sessions#create"
  get  "auth/verify", to: "sessions#verify"
  delete "logout",    to: "sessions#destroy"

  # Events & RSVPs
  resources :events, only: [ :index, :show ] do
    resource :rsvp, only: [ :create, :update, :destroy ]
  end

  # Admin
  namespace :admin do
    resources :events
    root to: "events#index"
  end

  root "pages#home"
end
