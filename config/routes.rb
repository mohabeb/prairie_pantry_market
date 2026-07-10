Rails.application.routes.draw do
  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  get "pages/:slug", to: "pages#show", as: "page"
end