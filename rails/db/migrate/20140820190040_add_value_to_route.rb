class AddValueToRoute < ActiveRecord::Migration
  def change
    add_column :route, :price_list, :float
  end
end
