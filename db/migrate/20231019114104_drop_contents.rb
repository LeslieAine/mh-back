class DropContents < ActiveRecord::Migration[7.0]
  def change
    drop_table :contents, force: :cascade
  end
end
