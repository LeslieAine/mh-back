class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :sender, null: false, foreign_key: true
      t.references :receiver, null: false, foreign_key: true
      t.text :content
      t.datetime :timestamp

      t.timestamps
    end
  end
end
