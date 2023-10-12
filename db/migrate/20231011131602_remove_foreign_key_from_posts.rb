class RemoveForeignKeyFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :posts, column: :user_id
  end
end
