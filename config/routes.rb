Rails.application.routes.draw do
  root "welcome#index"

  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  resource :profile, only: [:show]
  resources :families, only: [:create]
  resources :invitations, only: [:new, :create, :index]
end
