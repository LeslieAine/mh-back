class AddAcceptedByToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :accepted_by, foreign_key: { to_table: :users }
  end
end
