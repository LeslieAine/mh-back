class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :creator, null: false, foreign_key: true
      t.text :content
      t.datetime :timestamp

      t.timestamps
    end
  end
end
