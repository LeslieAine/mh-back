class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.text :description
      t.integer :length
      t.decimal :price, precision: 10, scale: 2
      t.integer :status, default: 0 # 0: pending, 1: accepted, 2: rejected
      t.references :client, foreign_key: { to_table: :users }
      t.references :creator, foreign_key: { to_table: :users }


      t.timestamps
    end
  end
end
