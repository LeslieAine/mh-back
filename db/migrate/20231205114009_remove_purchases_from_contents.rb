class RemovePurchasesFromContents < ActiveRecord::Migration[7.0]
  def change
    remove_column :contents, :purchases
  end
end
