class Post < ApplicationRecord
  # belongs_to :user #class_name: 'Creator', foreign_key: 'user_id'
  belongs_to :creator, class_name: 'Creator', foreign_key: 'creator_id'

  # Validations
  validates :content, presence: true

end
