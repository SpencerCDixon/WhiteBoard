Rails.application.routes.draw do
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect('/')

  resource :session, only: [:new, :create, :destroy]

  root "welcome#index"
end
