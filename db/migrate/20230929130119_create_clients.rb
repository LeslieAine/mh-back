class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.float :balance
      t.string :username
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
