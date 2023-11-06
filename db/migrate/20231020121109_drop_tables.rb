class DropTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :messages, force: :cascade
  end
end
