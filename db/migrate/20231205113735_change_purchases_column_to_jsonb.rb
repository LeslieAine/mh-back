class ChangePurchasesColumnToJsonb < ActiveRecord::Migration[7.0]
  def change
    change_column :contents, :purchases, :jsonb, default: []
  end
end
