class DropClients < ActiveRecord::Migration[7.0]
  def change
    drop_table :clients, force: :cascade
  end
end
