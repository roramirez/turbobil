class AddIndexToCall < ActiveRecord::Migration
  def change
    add_index :call, [:at, :customer_id], name: "idx_at_customer_on_call"
    add_index :call, [:at, :admin_id], name: "idx_at_admin_on_call"
  end
end
