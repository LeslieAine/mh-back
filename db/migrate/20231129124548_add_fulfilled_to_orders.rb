class AddFulfilledToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :fulfilled, :text
  end
end
