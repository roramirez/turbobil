class AddActiveToCustomer < ActiveRecord::Migration
  def change
    add_column :customer, :active, :boolean, :default => true
  end
end
