class DropOrders < ActiveRecord::Migration[7.0]
  def change
    drop_table :orders, force: :cascade
  end
end
