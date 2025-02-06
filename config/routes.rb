Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'dashboard#index', as: :dashboard

  resources :users do
    collection do
      get 'profile'
    end
  end
  
  resources :notes
  
  resources :tasks do
    member do
      patch 'update_status'
    end
    resources :subtasks, controller: 'tasks'
  end
  
  resources :wiki_pages do
    collection do
      get 'search'
    end
  end
  
  resources :simplebase_tables do
    resources :records, controller: 'simplebase_records'
  end
  
  resources :chat_messages, only: [:index, :create, :destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Password reset routes
  get 'reset_password/:token', to: 'users#reset_password', as: :reset_password
  post 'update_password', to: 'users#update_password', as: :update_password
end
