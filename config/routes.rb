Rails.application.routes.draw do
  get "cart/show"
  get "cart/add"
  get "cart/update"
  get "cart/remove"
  get "cart/clear"
  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  get "pages/:slug", to: "pages#show", as: "page"
end