ActiveAdmin.register Account, namespace: :admins do

  belongs_to :customer, :optional => true

  scope_to :current_admin

  permit_params :code, :customer_id, :ip_auth, :password,  codec_ids: []

  filter :customer, :collection => proc {Customer.where admin: current_admin }

  controller do
    after_save do |account|
      call_rake  :account_sip, :id => account.id
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :code,          :as => :string
      f.input :customer,      :as => :select, :collection => Customer.where(admin: current_admin)
    end
    f.inputs "Connection" do
      f.input :ip_auth,      :as => :string
      f.input :password,     :as => :string
      f.input :codecs,       :as => :check_boxes
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :code
      row :customer
      row :ip_auth
      row :password
      table_for account.codecs do
        column "Codecs" do |codec|
          codec.name
        end
      end
    end
  end

  index do
    column :code
    column :customer
    actions
  end

end
