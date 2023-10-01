class Favorite < ApplicationRecord
  # Associations
  belongs_to :client, class_name: 'Client', foreign_key: 'client_id'
  belongs_to :creator, class_name: 'Creator', foreign_key: 'creator_id'

  # Validations (You can add additional validations as needed)
  validates :client_id, presence: true
  validates :creator_id, presence: true
end
