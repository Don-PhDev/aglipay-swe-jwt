FactoryBot.define do
  factory :order do
    quantity { 2 }
    total_amount { 4 }
    user
    product
  end
end
