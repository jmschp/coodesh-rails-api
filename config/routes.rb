Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  root to: 'pages#home'
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [ :index, :show, :create, :update, :destroy]
    end
  end
  
  get "/api/v1", to: "api/v1/products#api_status", defaults: { format: :json }
  # post "/api/v1/upload_validation", to: "api/v1/products#upload_validation"

  
  # resources :products, only: [:edit, :update, :destroy]
  
  # post "upload_validation", to: "products#upload_validation"
end
