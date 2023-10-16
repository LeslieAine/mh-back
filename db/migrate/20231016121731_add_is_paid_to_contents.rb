class AddIsPaidToContents < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :isPaid, :boolean
  end
end
