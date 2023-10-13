class ModifyCreators < ActiveRecord::Migration[7.0]
  def change
    add_column :creators, :email, :string, null: false, default: ""
    add_column :creators, :encrypted_password, :string, null: false, default: ""
    add_column :creators, :reset_password_token, :string
    add_column :creators, :reset_password_sent_at, :datetime
    add_column :creators, :remember_created_at, :datetime

    add_index :creators, :email,                unique: true
    add_index :creators, :reset_password_token, unique: true
    # add_index :creators, :confirmation_token,   unique: true
    # add_index :creators, :unlock_token,         unique: true
  end

  end
