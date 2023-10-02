class AddFollowerAndFollowingToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :follower_id, :integer
    add_column :users, :following_id, :integer
  end
end
