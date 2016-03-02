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
    get '/newsfeed', to: :newsfeed, as: 'newsfeed'
    get '/create_resource', to: :create_resource, as: 'create_resource'
    get '/resources', to: :resources, as: 'resources'
    get '/shopping', to: :shopping, as: 'shopping'
    get '/user_settings', to: :user_settings, as: 'user_settings'
    get '/dashboard', to: :dashboard, as: 'dashboard_template'
    get '/newsfeed', to: :newsfeed, as: 'newsfeed_template'
    get '/pinboard', to: :pinboard, as: 'pinboard'
    get '/create_flat', to: :create_flat
    get '/finance_entry', to: :finance_entry, as: 'finance_entry'
    get '/bills_overview', to: :bills_overview, as: 'bills_overview'
    get '/finance_overview_mate', to: :finance_overview_mate, as: 'finance_overview_mate'
    get '/create_payment', to: :create_payment, as: 'create_payment'
  end

  #REST API
  namespace :api, defaults: {format: :json} do
   resources :status, only: [:index]
   resources :invite, only: [:create,:destroy]

   #Flat
   namespace :flat do
      get '/', to: :index
      put '/', to: :create
      post '/', to: :update
      get '/mates', to: :flat_mates
      post '/leave_flat', to: :leave_flat
   end

   #user
   resources :user, only: [:index]

   resources :shoppinglist, only: [:index, :create, :destroy] do
      resources :shoppingitem, only: [:create, :update, :destroy]
      delete '/delete_checked', to: :delete_checked
   end

   resources :newsfeed, only: [:index, :create, :destroy]
   post '/newsfeed/comment/' => 'newsfeed#comment'

   resources :resource, only: [:index, :create, :update, :destroy] do
      resources :resourceentry, only: [:create, :destroy]
   end
   get '/resource/:resource_id/resourceentry/' => 'resourceentry#page'
   get '/resource/:resource_id/chart' => 'resource#get_chart'
   get '/resource/:resource_id/overview' => 'resource#get_overview'
   get '/resource/:resource_id' => 'resource#get_by_id'

   get '/dashboard/resource' => 'resource#dashboard'

    #finances
   resources :bill, only: [:create, :update,:show, :destroy, :index]

   get '/finance/category' => 'finance#get_by_category'
   get '/finance/overviewMates' => 'finance#get_overview_mates'
   get '/finance/overviewMates/:mate_id/' => 'finance#get_overview_mate'



   post "/payment" => 'payment#create'
   delete "/payment/:id/:mate_id" => 'payment#destroy'
  end

  # Authentication
  match 'auth/:provider/callback', to: 'session#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  get "auth/join_flat/:token", to: "session#join", as: "join" 
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