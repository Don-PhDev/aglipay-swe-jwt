class Product < ApplicationRecord
  belongs_to :category
  has_many   :orders

  validates :name, presence: true
end
