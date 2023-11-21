class RemoveBookmarksFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :bookmarks, :integer
  end
end
