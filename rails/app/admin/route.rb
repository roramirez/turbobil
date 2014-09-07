ActiveAdmin.register Route do

  scope_to :current_admin

  permit_params :prefix, :name, :price_list

  filter :name
  filter :prefix

  form do |f|
    f.inputs "Details" do
      f.input :prefix,        :as => :string
      f.input :name,          :as => :string
      f.input :price_list
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :prefix
      row :name
      row :price_list
    end
  end

  index do
    column :prefix
    column :name
    column :price_list
    actions
  end

end
