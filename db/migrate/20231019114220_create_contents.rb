class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.references :user, null: false, foreign_key: true # This adds a foreign key to the users table
      t.string :title
      t.text :description
      t.decimal :price
      t.string :url
      
      t.timestamps
      t.boolean :isPaid
    end
  end
end
