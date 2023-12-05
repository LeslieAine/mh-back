class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :purchased_item, polymorphic: true, null: false
      t.decimal :amount

      t.timestamps
    end
  end
end
