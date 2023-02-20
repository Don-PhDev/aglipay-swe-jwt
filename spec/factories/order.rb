FactoryBot.define do
  factory :order do
    quantity { 10 }
    total_amount { 500 }
    user
    product
  end
end
