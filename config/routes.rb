Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: "sessions#failure"

  resource :session, only: [:new, :create, :destroy] do
    get "failure", on: :member
  end

  resource :profile, only: [:show]

  root "welcome#index"
end
