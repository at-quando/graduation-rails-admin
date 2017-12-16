Rails.application.routes.draw do
  resources :admins
  resources :users
  resources :shops
  resources :sessions
  put 'statistic' => 'home#update_statistic', :as => 'statistics'
  resources :assistants
  resources :statistics
  resources :products
  resources :properties
  resources :brands
  resources :orders
  resources :order_items
  resources :categories
  resources :category_brands, only: [:create]
  resources :process_orders, only: [:index]
  resources :process_admin_orders, only: [:index]
  delete 'destroy_relationship/:category_id' => 'category_brands#destroy_relationship', :as => 'destroy_relationship'
  post 'action' => 'categories#action', :as => 'action'
  post 'load_categories' => 'brands#load_categories', :as => 'load_categories'
  post 'load_process' => 'process_orders#load_process', :as => 'load_process'
  patch 'save_process' => 'process_orders#save_process', :as => 'save_process'
  post 'load_admin_process' => 'process_admin_orders#load_process', :as => 'load_admin_process'
  patch 'save_admin_process' => 'process_admin_orders#save_process', :as => 'save_admin_process'
  post 'get_brand' => 'products#getBrand'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  root 'home#index'
  get'/404', :to => 'errors#not_found'
  get'/422', :to => 'errors#unacceptable'
  get'/500', :to => 'errors#internal_error'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
