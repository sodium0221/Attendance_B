Rails.application.routes.draw do

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  
  resources :users do
    get :search, on: :collection
    member do
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
      get 'edit_basic_info'
      patch 'update_basic_info'
    end 
    resources :attendances, only: :update
    
  end
end
