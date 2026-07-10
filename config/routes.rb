Rails.application.routes.draw do
  get "orders/index"
  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  get "cart", to: "cart#show", as: "cart"
  post "cart/add/:id", to: "cart#add", as: "add_to_cart"
  patch "cart/update/:id", to: "cart#update", as: "update_cart"
  delete "cart/remove/:id", to: "cart#remove", as: "remove_from_cart"
  delete "cart/clear", to: "cart#clear", as: "clear_cart"

  get "checkout", to: "checkout#new", as: "checkout"
post "checkout", to: "checkout#create"

get "orders", to: "orders#index", as: "orders"
get "orders/:id", to: "checkout#show", as: "order"

  get "pages/:slug", to: "pages#show", as: "page"
end