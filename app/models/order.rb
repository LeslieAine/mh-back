class Order < ApplicationRecord
    belongs_to :client, class_name: 'Client'
    belongs_to :creator, class_name: 'Creator'
  
    enum status: { pending: 0, accepted: 1, rejected: 2 }
  
    validates :title, presence: true
    validates :description, presence: true
    validates :length, presence: true, numericality: { greater_than: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  
    # Custom method to set order status to "accepted"
    def accept!
      update(status: :accepted)
    end
  
    # Custom method to set order status to "rejected"
    def reject!
      update(status: :rejected)
    end
end
