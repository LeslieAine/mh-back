class CreateCreators < ActiveRecord::Migration[7.0]
  def change
    create_table :creators do |t|
      t.string :username
      t.float :balance
      t.string :portfolio

      t.timestamps
    end
  end
end
