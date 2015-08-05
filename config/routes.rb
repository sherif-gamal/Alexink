Rails.application.routes.draw do

  resources :productions

  match '/signin', :to => 'sessions#new', via: [:get]
  match '/signout', :to => 'sessions#destroy', via: [:get]
  match '/dashboard', to: 'dashboard#index', via: [:get]
  match '/stock', to: 'stock#index', via: [:get]
  match '/status', to: 'status#index', via: [:get]
  match '/diaries/treasury', to: 'diaries#treasury', via: [:get]
  match '/diaries/treasury', to: 'diaries#treasury', via: [:post]
  match '/diaries/transactions', to: 'diaries#transactions', via: [:get]
  match '/diaries/transactions', to: 'diaries#transactions', via: [:post]
  match '/diaries/stock', to: 'diaries#stock', via: [:get]
  match '/diaries/stock', to: 'diaries#stock', via: [:post]
  match '/diaries/diaries', to: 'diaries#diaries', via: [:get]
  match '/diaries/diaries', to: 'diaries#diaries', via: [:post]
  match '/invoices', to: 'invoices#purchases', via: [:get]
  match '/wear_outs', to: 'ehlak_osool#index', via: [:get]
  match '/wear_outs/update', to: 'ehlak_osool#update', via: [:post]

  get '/dashboard/index'
  get '/clients/status'
  get 'dashboard/*a/*b', to: redirect('/%{a}/%{b}')
  get 'stock/index'
  match '/taxes', to: 'taxes#index', via: [:get]
  match '/taxes', to: 'taxes#index', via: [:post]

  get 'permission/production/:id', to: 'permission#production'
  get 'permission/product/:id', to: 'permission#product'
  get 'permission/material_stock/:id', to: 'permission#material_stock'
  get 'permission/material_expense/:id', to: 'permission#material_expense'
  get 'permission/material/:id1/:id2', to: 'permission#material'
  get 'permission/purchase/:id1/:id2', to: 'permission#purchase_with_invoice'
  get 'permission/purchase/:id', to: 'permission#purchase'
  get 'permission/expense/:id', to: 'permission#expense'
  
  get 'diaries/index', to: 'diaries#diaries'
  post 'diaries/index', to: 'diaries#diaries'

  get 'raw_materials/production'
  post 'raw_materials/permit'
  get 'raw_materials/permission'
  post 'materials/confirm'
  post 'purchases/confirm'

  get 'invoices/sales'
  get 'invoices/purchases'
  get 'permission/additions'
  get 'permission/subtractions'
  get 'permission/treasury'

  post 'expenses/confirm'
  get 'expenses/permission'
  get 'expenses/index_general'
  get 'expenses/index_production'

  get 'purchases/invoice/:id', to: 'purchases#invoice'
  post 'materials/confirm'
  get 'materials/new_internal'
  get 'treasury/addtotreasury'
  get 'treasury/show'
  put 'treasury/update'


  get 'expense_payment_detail/:id', to: 'expense_payment_detail#edit'
  put 'expense_payment_detail/:id', to: 'expense_payment_detail#update'
  get 'purchase_payment_detail/:id', to: 'purchase_payment_detail#edit'
  put 'purchase_payment_detail/:id', to: 'purchase_payment_detail#update'
  get 'material_payment_detail/:id', to: 'material_payment_detail#edit'
  put 'material_payment_detail/:id', to: 'material_payment_detail#update'

  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :users

  resources :treasury

  resources :suppliers

  resources :clients

  resources :purchases

  resources :expenses

  resources :products

  resources :materials
  resources :raw_materials
  resources :purchase_payment_detail
  resources :expense_payment_detail
  resources :material_payment_detail

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
