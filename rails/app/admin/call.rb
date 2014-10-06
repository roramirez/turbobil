ActiveAdmin.register Call, namespace: :admins do

  scope_to :current_admin

  config.clear_action_items!
  actions :index, :show
  filter :customer, :collection => proc {Customer.where admin: current_admin }
  filter :provider, :collection => proc {Provider.where admin: current_admin }
  filter :route,  :collection => proc {Route.where admin: current_admin }
  #Please FIXME: This very ugly
  filter :dialstatus, :as => :select,  collection: [ ["ANSWER", "ANSWER"], ["CHANUNAVAIL", "CHANUNAVAIL"], ["NOANSWER", "NOANSWER"], ["CONGESTION", "CONGESTION"], ["BUSY", "BUSY"], ["CANCEL", "CANCEL"]]
  filter :at


  show do |ad|
    attributes_table do
      row :at
      row :provider
      row :route
      row :destination
      row :customer
      row :duration
      row "Duration", :sorteable => :duration do |call|
        call.duration_hhmmss
      end
      row :cost
      row :price_for_customer
      row :dialstatus
      row :ip

    end
  end

  index do
    column :at
    column :provider
    column :route
    column :destination
    column :customer
    column "Duration", :sorteable => :duration do |call|
      call.duration_hhmmss
    end
    column :cost
    column :price_for_customer
    column :dialstatus
    column :ip
    actions
  end

end
