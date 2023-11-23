class CreateAbouts < ActiveRecord::Migration[7.0]
  def change
    create_table :abouts do |t|
      t.text :description
      t.text :interests
      t.text :intentions
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
