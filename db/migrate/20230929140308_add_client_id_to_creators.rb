class AddClientIdToCreators < ActiveRecord::Migration[7.0]
  def change
    add_column :creators, :creator_id, :integer
  end
end
