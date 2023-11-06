class Post < ApplicationRecord
  # belongs_to :user #class_name: 'Creator', foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'user_id'

  # Validations
  validates :content, presence: true

end
