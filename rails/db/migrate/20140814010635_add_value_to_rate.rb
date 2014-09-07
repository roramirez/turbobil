class AddValueToRate < ActiveRecord::Migration
  def change
    add_column :rate, :price, :float
  end
end
