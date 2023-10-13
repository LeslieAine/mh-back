class DropCreators < ActiveRecord::Migration[7.0]
  def change
    drop_table :creators, force: :cascade
  end
end
