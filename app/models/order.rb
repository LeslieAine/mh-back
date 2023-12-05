class Order < ApplicationRecord
  belongs_to :user
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :ordered_by, class_name: 'User', foreign_key: :ordered_by_id
  belongs_to :rejected_by, class_name: 'User', optional: true
  # before_create :check_balance_and_reduce

  private

  # def check_balance_and_reduce(user)
  #   # Implement logic to check if the user has enough balance
  #   # Reduce balance based on the order price
  #   # Handle errors if balance is insufficient
  #   # user = current_user

  #   # Check if the user has enough balance
  #   if user.balance >= price
  #     user.balance -= price
  #   else
  #     raise StandardError, 'Insufficient balance to create the order'
  #   end
  # end
  
    validates :title, presence: true
    validates :description, presence: true
    validates :length, presence: true, numericality: { greater_than: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
end
