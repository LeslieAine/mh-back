class ChangeCreatorIdToUserIdInPosts < ActiveRecord::Migration[7.0]
  def change
    remove_index :posts, name: "index_posts_on_creator_id"
    
    # Rename the column
    rename_column :posts, :creator_id, :user_id

    # Add a new index
    add_index :posts, :user_id
  end
end
