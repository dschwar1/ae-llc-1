Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :departments
  resources :scopes
  resources :employees
  resources :jobs
  resources :scope_times
  resources :work_days
  
  #Authentication routes
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  
  #Static page routes
  get 'home' => 'home#home', as: :home
  get 'scheduling' => 'home#scheduling', as: :scheduling
  get 'projection' => 'home#projection', as: :projection
  get 'overview' => 'home#overview', as: :overview
  
  #Ajax
  #Projection page actions
  get 'reduce' => 'home#reduce', as: :reduce
  get 'change_dep_proj' => 'home#change_dep_proj', as: :change_dep_proj
  
  #Scheduling page actions
  get 'week_before' => 'home#week_before', as: :week_before
  get 'week_after' => 'home#week_after', as: :week_after
  get 'change_dep' => 'home#change_dep', as: :change_dep
  get 'select_emp' => 'home#select_emp', as: :select_emp
  get 'clear_emp' => 'home#clear_emp', as: :clear_emp
  post 'add_workday' => 'home#add_workday', as: :add_workday
  delete 'remove_workday' => 'home#remove_workday', as: :remove_workday
  get 'get_job_scopes' => 'home#get_job_scopes', as: :get_job_scopes
  
  #Root url
  root :to => 'home#home'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
