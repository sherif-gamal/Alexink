Rails.application.routes.draw do
  
  match '/signin', :to => 'sessions#new', via: [:get]
  match '/signout', :to => 'sessions#destroy', via: [:get]
  match '/dashboard', to: 'dashboard#index', via: [:get]
  match '/stock', to: 'stock#index', via: [:get]
  match '/diaries', to: 'diaries#index', via: [:get]

  get '/dashboard/index'
  get 'dashboard/*a/*b', to: redirect('/%{a}/%{b}')
  get 'stock/index'
  
  get 'diaries/index'

  get 'materials/production'
  post 'materials/permit'
  get 'materials/permission'
  post 'materials/confirm'
  post 'purchases/confirm'

  post 'expenses/confirm'
  get 'expenses/permission'

  get 'materials/success'
  get 'purchases/success'
  get 'purchases/invoice'
  post 'materials/confirm'
  get 'treasury/addtotreasury'
  get 'treasury/show'
  put 'treasury/update'

  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :users

  resources :treasury

  resources :suppliers

  resources :clients

  resources :purchases

  resources :expenses

  resources :products

  resources :materials

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'sessions#new'

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
