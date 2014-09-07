ActiveAdmin.register Rate do

  #scope_to :current_admin

  belongs_to :provider, :optional => true

  permit_params :provider_id, :route_id, :priority, :price

  filter :provider, :collection => proc {Provider.where admin: current_admin }
  filter :route, :collection => proc {Route.where admin: current_admin }

  form do |f|
    f.inputs "Details" do
      f.input :provider, :collection => Provider.where(admin: current_admin)
      f.input :route, :collection => Route.where(admin: current_admin)
      f.input :priority
      f.input :price
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :provider
      row :route
      row :priority
      row :price
    end
  end

  index do
    column :provider
    column :route
    column :priority
    column :price
    actions
  end

end
