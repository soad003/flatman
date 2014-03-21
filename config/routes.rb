Flatman::Application.routes.draw do

scope "(:locale)", locale: /en|de/ do
  root :to => 'templates/templates#index', as: 'dashboard'

  # Static routes
  get '/about', :to => 'public#about'
  get '/contact', :to => 'public#contact'
  get '/terms', :to => 'public#terms_and_privacy'

  # template routes
  namespace :templates do
    get '/finances', :to => 'templates#finances', as: 'finances'
    get '/flat_settings', :to => 'templates#flat_settings', as: 'flat_settings'
    get '/messages', :to => 'templates#messages', as: 'messages'
    get '/resources', :to => 'templates#resources', as: 'resources'
    get '/share', :to => 'templates#share',as: 'share'
    get '/shopping', :to => 'templates#shopping', as: 'shopping'
    get '/user_settings', :to => 'templates#user_settings', as: 'user_settings'
    get '/dashboard', :to => 'templates#dashboard', as: 'dashboard_template'
    get '/new_flat', :to => 'templates#new_flat'
  end

  get '/search', :to => 'search#show', as: 'search'

  #REST API
  namespace :api, defaults: {format: :json} do
   resources :flat, only: [:index, :create]
   resources :user, only: [:index]
  end

  # Authentication
  match 'auth/:provider/callback', to: 'session#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'session#destroy', as: 'signout', via: [:get, :post]
  match 'signin', to: 'session#index', as: 'signin', via: [:get, :post]

   # Error Routes
  match '/404', :to => 'errors#not_found', via: :all
  match '/500', :to => 'errors#server_error', via: :all
end


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
