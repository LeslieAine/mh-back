class Content < ApplicationRecord
   # Associations
   belongs_to :creator, class_name: 'Creator', foreign_key: 'creator_id'

   # Validations
   validates :title, presence: true
   validates :description, presence: true
   validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
   validates :url, presence: true
end
