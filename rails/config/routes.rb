Rails.application.routes.draw do
  get  'admins/price_customers/add_list'    => 'admins/price_customers#add_price_list',    as: :admins_price_customers_add_list
  post 'admins/price_customers/create_list' => 'admins/price_customers#create_price_list', as: :admins_price_customers_create_list

  get '/admins/price_customers/:id/edit_list'     => 'admins/price_customers#edit_price_list', as: :admins_price_customers_edit_list
  patch '/admins/price_customers/:id/update_list' => 'admins/price_customers#update_price_list', as: :admins_price_customers_update_list

  post '/admins/price_customers/:route/:price_customer/update_rate'   => 'admins/price_customers#update_rate', as: :admins_price_customers_update_rate

  devise_for :customers, ActiveAdmin::Devise.config.merge({path: '/customers'})
  devise_for :admins, ActiveAdmin::Devise.config.merge({path: '/admins'})
  ActiveAdmin.routes(self)
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

  #get  'customer'       => 'customer#index'
  #get  'customer/new'   => 'customer#new'
  #post 'customer/create'=> 'customer#create'


end
