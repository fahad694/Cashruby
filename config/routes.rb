Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root "items#index"
#put "/items", to: "items#add_stock"
  resources :sub_categories
  resources :categories
  resources :items do
    get  :search, on: :collection
    post :add_stock, on: :member
    post :remove_stock, on: :member
  end
  resources :users
  resources :orders
end
