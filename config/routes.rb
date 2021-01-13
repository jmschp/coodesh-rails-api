Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  root to: 'pages#home'
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :products, only: [ :index, :show ]
    end
  end

  get "/api/v1", to: "api/v1/products#api_status", defaults: { format: :json }

end
