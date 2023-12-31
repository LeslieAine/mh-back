class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.datetime :timestamp

      t.timestamps

      t.references :user, null: false, foreign_key: true
    end
  end
end
