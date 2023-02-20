FactoryBot.define do
  factory :order do
    quantity { 10 }
    user
    product
  end
end
