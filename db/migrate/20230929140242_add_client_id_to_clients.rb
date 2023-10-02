class AddClientIdToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :client_id, :integer
  end
end
