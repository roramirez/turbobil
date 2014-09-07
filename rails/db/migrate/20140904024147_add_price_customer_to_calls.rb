class AddPriceCustomerToCalls < ActiveRecord::Migration
  def change
    add_column :call, :price_for_customer, :float
  end
end
