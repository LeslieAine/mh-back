class AddCreatorIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :creator, null: false, foreign_key: true
  end
end
