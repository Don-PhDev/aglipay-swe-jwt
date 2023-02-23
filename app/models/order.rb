class Order < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :user
  belongs_to :product

  before_validation :compute_total_amount

  private

  def compute_total_amount
    self.total_amount = product.price * quantity if product && quantity
  end
end
