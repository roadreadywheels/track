Rails.application.routes.draw do
  root 'pages#index'

  resources :pages do 
    member do 
      get :delete
    end
  end

  resources :accounts do
    member do
      get :delete
    end
  end


  resources :stocks do 
    member do 
      get :delete
    end
    collection { post :import }
    collection { get :bulk_upload }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
