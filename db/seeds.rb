def seeder
  AdminUser.create!(
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password"
  ) if Rails.env.development?

  User.create!(
    email: "example@gmail.com",
    password: "password",
    password_confirmation: "password"
  )

  10.times do
    Category.create!(
      name: Faker::Commerce.unique.department
    )
  end

  30.times do
    Product.create!(
      category_id: Category.all.pluck(:id).sample,
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price.to_d,
    )
  end

  10.times do
    Order.create!(
      user_id: User.all.pluck(:id).sample,
      product_id: Product.all.pluck(:id).sample,
      quantity: rand(1...100).to_d
    )
  end
end

seeder

puts '-------------------------------'
puts 'Seed results:'
puts '-------------------------------'
puts "Users: #{User.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "Orders: #{Order.count}"
