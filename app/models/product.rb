class Product < ApplicationRecord
  belongs_to :category
  has_many   :orders, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { other_than: 0 }
end
