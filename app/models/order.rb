class Order < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :user
  belongs_to :product
end
