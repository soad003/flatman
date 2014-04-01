Flatman::Application.routes.draw do

scope "(:locale)", locale: /en|de/ do
  root :to => 'templates#index'

  # Static routes
  get '/about', :to => :about, controller: :public
  get '/contact', :to => :contact, controller: :public
  get '/terms', :to => :terms_and_privacy, controller: :public

  # template routes
  namespace :templates do
    get '/finances', to: :finances, as: 'finances'
    get '/flat_settings', to: :flat_settings, as: 'flat_settings'
    get '/create_resource', to: :create_resource, as: 'create_resource'
    get '/messages', to: :messages, as: 'messages'
    get '/resources', to: :resources, as: 'resources'
    get '/share', to: :share, as: 'share'
    get '/shareditem', to: :shareditem, as: 'shareditem'
    get '/shopping', to: :shopping, as: 'shopping'
    get '/user_settings', to: :user_settings, as: 'user_settings'
    get '/dashboard', to: :dashboard, as: 'dashboard_template'
    get '/create_flat', to: :create_flat
    get '/search', to: :search, as: 'search'
    get '/message_window', to: :message_window, as: 'message_window'
    get '/message_new', to: :message_new, as: 'message_new'
  end

  #REST API
  namespace :api, defaults: {format: :json} do
   resources :status, only: [:index]
   get '/search/:term' => 'search#search'
   namespace :flat do
      get '/', to: :index
      put '/', to: :create
      post '/', to: :update
   end
   resources :user, only: [:index]
   resources :resource, only: [:index, :create, :update, :destroy] do
      resources :resourceentry, only: [:index, :create, :destroy]
   end

   resources :share, only: [:index, :create]
   resources :shareditem, only: [:index, :create]
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
