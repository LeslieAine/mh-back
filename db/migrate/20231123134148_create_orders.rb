class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.text :description
      t.integer :length
      t.decimal :price, precision: 10, scale: 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
