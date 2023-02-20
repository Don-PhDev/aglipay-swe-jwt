class Order < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :user
  belongs_to :product

  validate :total_amount do
    if product.present? && total_amount != product.price * quantity
      errors.add(:total_amount, "should be equal to product.price times quantity")
    end
  end
end
