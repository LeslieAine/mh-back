class Post < ApplicationRecord
  belongs_to :creator, class_name: 'Creator', foreign_key: 'creator_id'

  # Validations
  validates :timestamp, presence: true

end
