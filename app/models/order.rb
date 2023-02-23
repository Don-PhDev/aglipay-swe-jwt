class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0 }
  validate  :total_amount_equal_to_price_times_quantity

  private

  def total_amount_equal_to_price_times_quantity
    return unless product.present?
    errors.add(:total_amount, "should be equal to product.price times quantity") unless total_amount == product.price * quantity
  end
end
