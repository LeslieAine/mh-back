class AddPurchasesToContents < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :purchases, :jsonb, default: []
  end
end
