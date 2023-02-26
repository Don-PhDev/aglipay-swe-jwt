class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, numericality: { greater_than: 0, message: "must be greater than 0" }
  validate :calculate_total_amount

  private

  def calculate_total_amount
    if product.present? && self.total_amount != product.price * quantity
      errors.add(:total_amount, "should be equal to product.price times quantity")
    end
  end
end
