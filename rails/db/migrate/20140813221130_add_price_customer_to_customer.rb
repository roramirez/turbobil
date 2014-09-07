class AddPriceCustomerToCustomer < ActiveRecord::Migration
  def change
    add_reference :customer, :price_customer, index: true
  end
end
