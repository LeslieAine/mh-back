class AddBookmarksToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :bookmarks, :integer, array: true, default: [] 
  end
end
