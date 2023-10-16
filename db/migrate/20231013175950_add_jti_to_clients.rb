class AddJtiToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :jti, :string
    add_index :clients, :jti, unique: true

  end
end
