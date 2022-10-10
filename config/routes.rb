Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root "items#index"
  resources :sub_categories
  resources :categories
  resources :items do
    get  :search, on: :collection
    post :add_stock, on: :member
    post :remove_stock, on: :member
  end
  
  resources :orders do
    post   :add_item, on: :member
    delete :remove_item, on: :member
    post   :charge_payment, on: :member
  end
  resources :users do
    post :create_user, on: :collection 
    get  :user_profile, on: :member
  end
end
