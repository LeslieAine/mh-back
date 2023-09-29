class Transaction < ApplicationRecord
  belongs_to :client, class_name: 'Client', foreign_key: 'client_id'
  belongs_to :creator, class_name: 'Creator', foreign_key: 'creator_id'

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: ['deposit', 'purchase'] }
  validates :timestamp, presence: true
end
