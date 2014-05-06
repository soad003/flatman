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
    get '/upload', to: :upload, as: 'upload'
    get '/shopping', to: :shopping, as: 'shopping'
    get '/user_settings', to: :user_settings, as: 'user_settings'
    get '/dashboard', to: :dashboard, as: 'dashboard_template'
    get '/create_flat', to: :create_flat
    get '/search', to: :search, as: 'search'
    get '/finances_new', to: :finances_new, as: 'finances_new'
    get '/finances_overview', to: :finances_overview, as: 'finances_overview'
    get '/create_message', to: :create_message, as: 'create_message'
  end

  #REST API
  namespace :api, defaults: {format: :json} do
   resources :status, only: [:index]
   resources :invite, only: [:create,:destroy]
   get '/search/:term' => 'search#search'

   namespace :flat do
      get '/', to: :index
      put '/', to: :create
      post '/', to: :update
   end
   resources :user, only: [:index]
   
   
   resources :shoppinglist, only: [:index, :create, :destroy] do
      resources :shoppingitem, only: [:create, :update, :destroy]
   end
	resources :resource, only: [:index, :create, :update, :destroy] do
      resources :resourceentry, only: [:create, :destroy]
   end
   get '/resource/:resource_id/resourceentry/:page' => 'resourceentry#page'
   get '/resource/:resource_id/chart' => 'resource#get_chart'
   get '/resource/:resource_id/overview' => 'resource#get_overview'
   get '/resource/:resource_id' => 'resource#get_by_id'

   get '/dashboard/resource' => 'resource#dashboard'

   #messages
   resources :message, only: [:index, :create, :update, :destroy]
   
   get '/message/:mes_id/messages' => 'message#get_messages'
   get '/message/:mes_id/partner' => 'message#find_partner'
   get '/message/users' => 'message#get_users'
   get '/message/:mes_id/counter' => 'message#count_messages'

   #sharing
   get '/shareditem/:id' => 'shareditem#get'
   post '/shareditem/:id' => 'shareditem#update'
   resources :share, only: [:index, :create, :destroy]
   resources :shareditem, only: [:index, :create, :update, :upload]
   
   #finances
   resources :finance, only: [:index, :create, :update, :destroy]
   get '/finance/category' => 'finance#get_all'
   get '/finance/chart' => 'finance#get_chart'
   get '/finance/debts' => 'finance#get_debts'
   get '/finance/mates' =>  'finance#get_mates'
   get '/finance/month' => 'finance#get_month'
   
   post '/upload' => 'upload#create'
   get '/upload' => 'upload#new'
   
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
