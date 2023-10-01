class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.references :creator, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :price
      t.string :url

      t.timestamps
    end
  end
end
