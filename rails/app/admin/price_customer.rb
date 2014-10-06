ActiveAdmin.register PriceCustomer, namespace: :admins do

  scope_to :current_admin

  permit_params :name, :percent_recharge


  config.clear_action_items!
  actions :index

  controller do
    def scoped_collection
      PriceCustomer.select("route.*, price_customer.*, route.id as route_id, route.name AS route_name").joins("join route ON route.admin_id = price_customer.admin_id ").where(admin: current_admin)
    end

    def add_price_list
      @price_customer = PriceCustomer.new
      render layout: false
    end

    def create_price_list
      @price_customer = PriceCustomer.new(permitted_params[:price_customer])
      @price_customer.admin = current_admin
      @price_customer.save
      render 'update_response', layout: false
    end

    def edit_price_list
      @price_customer = PriceCustomer.find(params[:id])
      render layout: false
    end
    def update_price_list
      @price_customer = PriceCustomer.find(params[:id])
      @price_customer.update(permitted_params[:price_customer])
      render 'update_response', layout: false
    end

    def update_rate
      @rate_customer = RateCustomer.where(
        route_id: params[:route],
        price_customer_id: params[:price_customer]
      ).first_or_initialize

      # there's probably better ways of doing this
      # params[:value].to_f returns 0.0 for all invalid values
      value_as_float = Float(params[:value]) rescue nil
      if value_as_float
        @rate_customer.value = value_as_float
        @rate_customer.save
        render layout: false
      else
        #http://edgeguides.rubyonrails.org/layouts_and_rendering.html
        render status: :bad_request
      end
    end

  end

  filter :id , :as => :select, :label => "Name price list", :collection => proc {PriceCustomer.where admin: current_admin }


  action_item only: :index do
    link_to 'Add price list', admins_price_customers_add_list_path, class: 'fancybox', data: { 'fancybox-type' => 'ajax' }
  end

  form do |f|
    f.inputs "Details" do
      f.input :name,             :as => :string
      f.input :percent_recharge
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :percent_recharge
    end
  end

  index do
    column "Name list" do |price|
      link_to price.name, admins_price_customers_edit_list_path(price), class: 'fancybox', data: { 'fancybox-type' => 'ajax' }
    end
    column :prefix
    column "Route", :route_name
    column :percent_recharge


    column :price_list
    column "Final Price" do |rate|
      edit_rate_customer rate,  rate.final_price_for_route(rate.route_id, rate.price_list)
    end

  end

end
