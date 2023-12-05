class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :purchased_item, polymorphic: true
  validates :user_id, presence: true
  validates :purchased_item_id, presence: true
  # validates :purchased_item_type, presence: true
  validates :amount, numericality: { greater_than: 0 }

  before_create :deduct_balance

  private

  def deduct_balance
    # Implement logic to deduct balance for immediate purchases
    # Update user's balance accordingly
    user = User.find(user_id)

    # Check if the user has enough balance
    if user.balance >= amount
      # Deduct the purchase amount from the user's balance
      user.balance -= amount

      # Save the updated user balance
      user.save
    else
      # Handle insufficient balance (e.g., raise an error)
      errors.add(:base, 'Insufficient balance for the purchase')
      throw(:abort)
    end
  end
end
