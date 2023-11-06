class AddTitleToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :title, :string
  end
end
