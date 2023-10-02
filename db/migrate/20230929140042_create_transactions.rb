class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :client, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: true
      t.float :amount
      t.string :transaction_type
      t.datetime :timestamp

      t.timestamps
    end
  end
end
