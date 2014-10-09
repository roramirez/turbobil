Rails.application.routes.draw do
  get  'admins/price_customers/add_list'    => 'admins/price_customers#add_price_list',    as: :admins_price_customers_add_list
  post 'admins/price_customers/create_list' => 'admins/price_customers#create_price_list', as: :admins_price_customers_create_list

  get '/admins/price_customers/:id/edit_list'     => 'admins/price_customers#edit_price_list', as: :admins_price_customers_edit_list
  patch '/admins/price_customers/:id/update_list' => 'admins/price_customers#update_price_list', as: :admins_price_customers_update_list

  post '/admins/price_customers/:route/:price_customer/update_rate'   => 'admins/price_customers#update_rate', as: :admins_price_customers_update_rate

  devise_for :admins, ActiveAdmin::Devise.config.merge({path: '/admins'})
  ActiveAdmin.routes(self)

  get  'customer/calls'  => 'customer#calls'
  get  'customer/accounts'  => 'customer#accounts'
  get  'customer/prices'  => 'customer#prices'
  devise_for :customers, :path => '/customer', controllers: { sessions: :sessions }
  get "/customer" => "customer#dashboard"
  get "/customer/account/:id" => "customer#edit_account", as: 'account'
  post "/customer/account" => "customer#update_account"
  get '/customer/profile' =>  'customer#profile', as: :customer_profile
  post '/customer/profile' =>  'customer#update_profile', as: :customer_update_profile
end
